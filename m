From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: FSUSB Port on OMAP2430 SDP
Date: Wed, 1 Aug 2007 14:16:37 -0500
Message-ID: <6E3DC4E6E09EF440B55B7AD683608D6D01836ABA@dlee13.ent.ti.com>
References: <78d6ed630708011203j8e9e7a1q4ee053e39f538f5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <78d6ed630708011203j8e9e7a1q4ee053e39f538f5f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Amit Gupta <amit_jobs05@inbox.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Amit

-----------------------------------------
From: Amit Gupta
Sent: Wednesday, August 01, 2007 2:04 PM
=20
> Actually I am connecting mini B plug to the mini AB receptcle of FSUSB =
port 0.=20

Oh, that's the problem. A mini-A cable has to be plugged in to go to =
host mode.


> I am not able to get the mini A plug to standard B cable available in =
India( which I am not sure if its mandatory)

Its mandatory according to the USB spec, and the way the isp1301_omap.c =
driver detects the A-device/B-device mode. However, for testing purposes =
you might be able to hack isp1301_omap.c to allow working as a host with =
mini-B cable plugged in.

=09
> Should I connect the powered hub at the other end of female cable.=20

Won't help unless you use the mini-A - to standard-A female adapter, or =
do the hack as mentioned above.

> The powered hubs have their own power mechanism ?=20

Yes, powered hubs don't need the host to supply current for their =
operation.


Regards,
Nishant
