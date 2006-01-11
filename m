From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: [PATCH] 24xx dma patch
Date: Tue, 10 Jan 2006 23:12:07 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726380236B39A@dlee03.ent.ti.com>
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
To: kyungmin.park@samsung.com, Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> P.S., There's some problem when running qtopia on H4.
> At the end of mediaplay. we can't stop audio, exactly audio_sync why?
> But madplay is working well :)
I suspect we might be missing callback interrupts some place. The sync
waits for the buffers to be drained. If the draining never happened, it
implies that we have a mismatch at some point...
Regards,
Nishanth Menon
