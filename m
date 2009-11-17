From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
Date: Tue, 17 Nov 2009 23:20:36 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA689E6A@dbde02.ent.ti.com>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
 <20091116133654.14128.175.stgit@localhost.localdomain>
 <20091116140830.GA31522@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.0911171036430.27682@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39182 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbZKQRu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 12:50:57 -0500
In-Reply-To: <alpine.DEB.2.00.0911171036430.27682@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?iso-8859-1?Q?Juha_Lepp=E4nen?= <juha_motorsportcom@luukku.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.k=
ernel.org] On Behalf Of Paul
>Walmsley
>Sent: Tuesday, November 17, 2009 11:39 AM
>To: Russell King - ARM Linux
>Cc: linux-arm-kernel@lists.infradead.org; Juha Lepp=E4nen; linux-omap@=
vger.kernel.org
>Subject: Re: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
<snip>
>
>+/**
>+ * omap_test_timeout - busy-loop, testing a condition
>+ * @cond: condition to test until it evaluates to true
>+ * @timeout: maximum number of microseconds in the timeout
>+ * @index: loop index (integer)
>+ *
>+ * Loop waiting for @cond to become true or until at least @timeout
>+ * microseconds have passed.  To use, define some integer @index in t=
he
>+ * calling code.  After running, if @index =3D=3D @timeout, then the =
loop has
>+ * timed out.
>+ */
>+#define omap_test_timeout(cond, timeout, index)			\
>+({								\
>+	for (index =3D 0; index < timeout; index++) {		\
>+		if (cond)					\
>+			break;					\
>+		udelay(1);					\
>+	}							\
>+})
>+

There is a similar kind of function implemented in USB host, that retur=
ns -ETIMEDOUT
Which makes more sense for failure case.

Maybe such a generic function for all omaps is needed.

Refer:
drivers/usb/host/ehci-hcd.c
static int handshake (struct ehci_hcd *ehci, void __iomem *ptr,
                      u32 mask, u32 done, int usec)
{
        u32     result;

        do {
                result =3D ehci_readl(ehci, ptr);
                if (result =3D=3D ~(u32)0)          /* card removed */
                        return -ENODEV;
                result &=3D mask;
                if (result =3D=3D done)
                        return 0;
                udelay (1);
                usec--;
        } while (usec > 0);
        return -ETIMEDOUT;
}


> #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
>--
>1.6.5.GIT
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
