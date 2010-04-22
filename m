From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 4/4][v3] OMAP:iommu- add TLB preservation support
Date: Wed, 21 Apr 2010 19:19:35 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3C078F@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF953@dlee03.ent.ti.com>
 <20100421.090227.189716355.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34673 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866Ab0DVATp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 20:19:45 -0400
In-Reply-To: <20100421.090227.189716355.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "tony@atomide.com" <tony@atomide.com>

Hi Hiroshi,

> > @@ -241,6 +238,11 @@ int load_iotlb_entry(struct iommu *obj, struct
> iotlb_entry *e)
> >  			break;
> >  	}
> >
> > +	if (l.base == obj->nr_tlb_entries) {
> > +		dev_dbg(obj->dev, "%s: preserve entries full\n", __func__);
> > +		err = -EBUSY;
> 
> I am afraid that this doesn't work. There are two cases where TLB
> entries are set/updated:
> 
> 1) H/W TWL always updates TLB entries automatically, IOW, increments
>    "vict" implicitly.
> 2) A client module adds preservation TLB entry with explictly calling
>    "load_iotlb_entry()". IOW, increments both  "vict" and "base"
>    intentionally.
> 
> Because of 1), "vict" gets full soon and this is normal, but even if
> this "vict" is full, a preservation entry "base" should be able to be
> set by a client module unless "base" itself rearches full. IOW, Even
> if all TLB entries are valid, a new preservation TLB entry should be
> set by replacing one of the existing normal entry.
> 
> In the case of "e" with perservation bit , "load_iotlb_entry()"
> doesn't usually fail because it replaces the exisiting normal entry,
> but it would fail only if all TLB entries are preserved.
> 

-- I agree with your comments. My implementation was under the assumption that the User locks the TLB entries only at startup time, but as you mentioned this would not work during run time as the entries would already be having valid entries. DSPBridge and the OMAP4 IPCs both locks the entries at init time.

The following changes in load_tlb_entry function should handle the run time case too. This change would lock an entry irrespective of existing entry is valid or not.
Please let me know if you agree.

@@ -230,22 +227,32 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)

        clk_enable(obj->clk);

-       for (i = 0; i < obj->nr_tlb_entries; i++) {
-               struct cr_regs tmp;
-
-               iotlb_lock_get(obj, &l);
-               l.vict = i;
-               iotlb_lock_set(obj, &l);
-               iotlb_read_cr(obj, &tmp);
-               if (!iotlb_cr_valid(&tmp))
-                       break;
-       }
-
-       if (i == obj->nr_tlb_entries) {
-               dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
+       iotlb_lock_get(obj, &l);
+       if (l.base == obj->nr_tlb_entries) {
+               dev_dbg(obj->dev, "%s: preserve entries full\n", __func__);
                err = -EBUSY;
                goto out;
        }
+       if (!e->prsvd) {
+               for (i = l.base; i < obj->nr_tlb_entries; i++) {
+                       struct cr_regs tmp;
+
+                       iotlb_lock_get(obj, &l);
+                       l.vict = i;
+                       iotlb_lock_set(obj, &l);
+                       iotlb_read_cr(obj, &tmp);
+                       if (!iotlb_cr_valid(&tmp))
+                               break;
+               }
+               if (i == obj->nr_tlb_entries) {
+                       dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
+                       err = -EBUSY;
+                       goto out;
+               }
+       } else {
+               l.vict = l.base;
+               iotlb_lock_set(obj, &l);
+       }

        cr = iotlb_alloc_cr(obj, e);
        if (IS_ERR(cr)) {
@@ -256,9 +263,11 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
        iotlb_load_cr(obj, cr);
        kfree(cr);

+       if (e->prsvd)
+               l.base++;
        /* increment victim for next tlb load */
        if (++l.vict == obj->nr_tlb_entries)
-               l.vict = 0;
+               l.vict = l.base;
        iotlb_lock_set(obj, &l);
 out:
        clk_disable(obj->clk);
--

Thank you,
Best regards,
Hari
