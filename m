From: "Kamat, Nishant" <nskamat@ti.com>
Subject: RE: FSUSB Port on OMAP2430 SDP
Date: Wed, 1 Aug 2007 16:59:37 -0500
Message-ID: <6E3DC4E6E09EF440B55B7AD683608D6D01836C20@dlee13.ent.ti.com>
References: <78d6ed630708011242m7adadb5albd41f3ff8c489601@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <78d6ed630708011242m7adadb5albd41f3ff8c489601@mail.gmail.com>
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

Amit,

--------------------------
From: Amit Gupta
Sent: Wednesday, August 01, 2007 2:42 PM
=09
>>Hacking of isp1301_omap.c is not very clear to me ?=20

In isp1301_set_host(), interrupts are enabled for ID_GND (=3D> mini-A =
connectors). Maybe enabling interrupts for ID_FLOAT (mini-B connectors), =
and making sure that you move to the A-host state in the interrupt =
handler will make it work for you.

=09
> 	Do I need to set the OTG Control registerS Vbus_drv bit  ?=20
Yes.

> and should I do the same within the isp1301_set_host() of =
isp1301_omap.c.
Yes.


>  That is what seems to me? but still i am not sure about the =
transceiver logic, whether it wil read the id pin continously and power =
up/down the vbus accordingly ?=20

It will read the ID pin continuously, but generate interrupts for only =
those transitions that you enable. It won't turn VBUS on or off =
automatically based on ID value.

Regards,
Nishant
