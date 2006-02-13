From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: [PATCH] omap camera
Date: Mon, 13 Feb 2006 10:01:55 -0600
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA60244DAE3@dlee05.ent.ti.com>
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
To: Paul Mundt <paul.mundt@nokia.com>, David Cohen <david.cohen@indt.org.br>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Omap1 and omap2 camera drivers were developed independently. Omap2
drivers relies on a few omap2 advanced features (DSS, auto frame start
detection, camera DMA) Given their current status, it would be difficult
to merge them in practice.

Video-buf.c does the scatter-gather. Camera driver only uses the
scattered buffers. I don't know DMA API even does scatter-gather?

Enabling MMU would make scatter-gather unnecessary but it would make the
use of video-buf.c not easy. There is no plan to enable MMU as of today.

Regards,
Jian    =20

-----Original Message-----
From: linux-omap-open-source-bounces+jzhang=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+jzhang=3Dti.com@linux.omap.com] =
On
Behalf Of Paul Mundt
Sent: Saturday, February 11, 2006 12:34 AM
To: David Cohen
Cc: Linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] omap camera

On Fri, Feb 10, 2006 at 05:03:23PM -0400, David Cohen wrote:
> I don't think it is appropriate to use a common driver (camera_core)
for
> the omap 2420 and 1611/1710. I guess creating a common driver for
omap1
> (current camera_core) and other for omap2 (an updated camera_core)
could
> be better. Any comment?

Perhaps you can explain a little more why you feel it's inappropriate
for
omap1 and omap2 to share the same camera_core?

Also, why is this driver doing its own scatter-gather processing rather
than working with the DMA mapping API?

Plans for actually doing something wih the MMU?
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
