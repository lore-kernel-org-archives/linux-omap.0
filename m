From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] omap camera
Date: Mon, 13 Feb 2006 15:15:53 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA60244DF1C@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>, Paul Mundt <paul.mundt@nokia.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Some corrections.

-----Original Message-----
From: linux-omap-open-source-bounces+jzhang=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+jzhang=3Dti.com@linux.omap.com] =
On
Behalf Of Zhang, Jian
Sent: Monday, February 13, 2006 3:14 PM
To: Paul Mundt
Cc: Linux-omap-open-source@linux.omap.com
Subject: RE: [PATCH] omap camera

Paul,

I got what you meant by DMA-API. Yes, video-buf.c calls those APIs. The
purpose of video-buf.c is to provide convenience. You will need to
duplicate some video-buf code in the camera driver if you skip
video-buf.

By disabling camera MMU, I have to use scatterlists. Otherwise, the
buffer would have to be physically contiguous. For example, you would
NOT be
able to DMA the image to a user buffer that consist of a set of discrete
page frames in a single DMA transfer.=20

Can you send your code in a separate e-mail to me?

Regards,
Jian     =20


-----Original Message-----
From: Paul Mundt [mailto:paul.mundt@nokia.com]=20
Sent: Monday, February 13, 2006 2:54 PM
To: Zhang, Jian
Cc: David Cohen; Linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] omap camera

On Mon, Feb 13, 2006 at 10:01:55AM -0600, Zhang, Jian wrote:
> Omap1 and omap2 camera drivers were developed independently. Omap2
> drivers relies on a few omap2 advanced features (DSS, auto frame start
> detection, camera DMA) Given their current status, it would be
difficult
> to merge them in practice.
>=20
> Video-buf.c does the scatter-gather. Camera driver only uses the
> scattered buffers. I don't know DMA API even does scatter-gather?
>=20
See Documentation/DMA-API.txt. It'll deal with the mapping and unmapping
of the scatterlists, but you'll still have to deal with the transfer
handling. I suppose the video-buf.c management code wraps in to this
already for you at first glance..

> Enabling MMU would make scatter-gather unnecessary but it would make
the
> use of video-buf.c not easy. There is no plan to enable MMU as of
today.
>=20
Perhaps not, but you would be able to do away with most of the bounce
buffers. Not to mention, you can also pre-fault the camera TLB and not
even bother with a page fault handler. The TLB miss is also easy to
handle..

This should be trivial to deal with if you implement your own mmap()
(and
possibly get_unmapped_area()) for the camera driver itself. You should
be
able to zero-copy the read and write to this space. I'm not sure why
you'd even want to bother with scatterlists. Can you explain the use
case
where the scatterlists are going to be useful?

For what it's worth, I have some code already for manipulating the
camera, IVA, and DSP MMUs on OMAP2420 that I can make available if
someone is interested in working on this.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
