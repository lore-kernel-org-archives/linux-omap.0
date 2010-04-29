From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks to spinlock
Date: Thu, 29 Apr 2010 07:44:28 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B661D06@dlee03.ent.ti.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
 <1272390982-14882-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55458 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932634Ab0D3REv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 13:04:51 -0400
In-Reply-To: <1272390982-14882-2-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Ohad, 

Looks like the conversion was missed in few places resulting in compile warnings.

Please see the below fix. Let me know if you agree with the change.

#########
[PATCH] omap: mailbox: rwlocks to spinlock: compilation fix

fixed the missed  rwlocks in few places resultion in following
compiler warning.

arch/arm/plat-omap/mailbox.c: In function 'omap_mbox_startup':
arch/arm/plat-omap/mailbox.c:246: warning: passing argument 1 of '_raw_write_lock' from incompatible pointer type
arch/arm/plat-omap/mailbox.c:251: warning: passing argument 1 of '_raw_write_unlock' from incompatible pointer type
arch/arm/plat-omap/mailbox.c:255: warning: passing argument 1 of '_raw_write_unlock' from incompatible pointer type
arch/arm/plat-omap/mailbox.c: In function 'omap_mbox_fini':
arch/arm/plat-omap/mailbox.c:301: warning: passing argument 1 of '_raw_write_lock' from incompatible pointer type
arch/arm/plat-omap/mailbox.c:306: warning: passing argument 1 of '_raw_write_unlock' from incompatible pointer type

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 27a8d98..d6a700d 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -243,16 +243,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
        struct omap_mbox_queue *mq;

        if (likely(mbox->ops->startup)) {
-               write_lock(&mboxes_lock);
+               spin_lock(&mboxes_lock);
                if (!mbox_configured)
                        ret = mbox->ops->startup(mbox);

                if (unlikely(ret)) {
-                       write_unlock(&mboxes_lock);
+                       spin_unlock(&mboxes_lock);
                        return ret;
                }
                mbox_configured++;
-               write_unlock(&mboxes_lock);
+               spin_unlock(&mboxes_lock);
        }

        ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -298,12 +298,12 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
        free_irq(mbox->irq, mbox);

        if (likely(mbox->ops->shutdown)) {
-               write_lock(&mboxes_lock);
+               spin_lock(&mboxes_lock);
                if (mbox_configured > 0)
                        mbox_configured--;
                if (!mbox_configured)
                        mbox->ops->shutdown(mbox);
-               write_unlock(&mboxes_lock);
+               spin_unlock(&mboxes_lock);
        }
 }

--

################

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com] 
> Sent: Tuesday, April 27, 2010 12:56 PM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Hiroshi Doyu; Ohad Ben-Cohen
> Subject: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks 
> to spinlock
> 
> rwlocks are slower and have potential starvation issues so 
> spinlocks are generally preferred
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  arch/arm/plat-omap/mailbox.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mailbox.c 
> b/arch/arm/plat-omap/mailbox.c index 08a2df7..d73d51a 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -31,7 +31,7 @@
>  
>  static struct workqueue_struct *mboxd;
>  static struct omap_mbox *mboxes;
> -static DEFINE_RWLOCK(mboxes_lock);
> +static DEFINE_SPINLOCK(mboxes_lock);
>  
>  static int mbox_configured;
>  
> @@ -330,14 +330,14 @@ struct omap_mbox *omap_mbox_get(const 
> char *name)
>  	struct omap_mbox *mbox;
>  	int ret;
>  
> -	read_lock(&mboxes_lock);
> +	spin_lock(&mboxes_lock);
>  	mbox = *(find_mboxes(name));
>  	if (mbox == NULL) {
> -		read_unlock(&mboxes_lock);
> +		spin_unlock(&mboxes_lock);
>  		return ERR_PTR(-ENOENT);
>  	}
>  
> -	read_unlock(&mboxes_lock);
> +	spin_unlock(&mboxes_lock);
>  
>  	ret = omap_mbox_startup(mbox);
>  	if (ret)
> @@ -363,15 +363,15 @@ int omap_mbox_register(struct device 
> *parent, struct omap_mbox *mbox)
>  	if (mbox->next)
>  		return -EBUSY;
>  
> -	write_lock(&mboxes_lock);
> +	spin_lock(&mboxes_lock);
>  	tmp = find_mboxes(mbox->name);
>  	if (*tmp) {
>  		ret = -EBUSY;
> -		write_unlock(&mboxes_lock);
> +		spin_unlock(&mboxes_lock);
>  		goto err_find;
>  	}
>  	*tmp = mbox;
> -	write_unlock(&mboxes_lock);
> +	spin_unlock(&mboxes_lock);
>  
>  	return 0;
>  
> @@ -384,18 +384,18 @@ int omap_mbox_unregister(struct 
> omap_mbox *mbox)  {
>  	struct omap_mbox **tmp;
>  
> -	write_lock(&mboxes_lock);
> +	spin_lock(&mboxes_lock);
>  	tmp = &mboxes;
>  	while (*tmp) {
>  		if (mbox == *tmp) {
>  			*tmp = mbox->next;
>  			mbox->next = NULL;
> -			write_unlock(&mboxes_lock);
> +			spin_unlock(&mboxes_lock);
>  			return 0;
>  		}
>  		tmp = &(*tmp)->next;
>  	}
> -	write_unlock(&mboxes_lock);
> +	spin_unlock(&mboxes_lock);
>  
>  	return -EINVAL;
>  }
> --
> 1.6.3.3
> 
> 