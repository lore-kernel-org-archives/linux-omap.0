From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: about OMAP usb Speed?
Date: Thu, 12 Apr 2007 05:54:26 -0500
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F013E3F58@dlee11.ent.ti.com>
References: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The OMAP5912 implements an USB v1.1 client, host and On-The-Go
controllers.  USB v1.1 specifies full-speed (12Mbps) and low-speed
(1.5Mbps) data rates.

The hardware peripherals inside the OMAP5912 will not support
high-speed, therefore it is impossible to support high-speed with the
integrated USB peripherals on the device.  Alternative devices could be
used to provide high-speed support, but that would require a custom
board.

Regards,=20

Brandon Azbell=20
Texas Instruments=20
Senior, Group Technical Staff=20
System Applications=20

-----Original Message-----
From: linux-omap-open-source-bounces+b-azbell=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+b-azbell=3Dti.com@linux.omap.com]
On Behalf Of Wael Adel
Sent: Wednesday, April 11, 2007 7:28 PM
To: linux-omap-open-source@linux.omap.com
Subject: about OMAP usb Speed?

hi all,
i have an OMAP-OSK5912, as for its usb bus i know that it is a
full-speed (12Mbps)
isnt there any way or any patch that make it support for high-speed
(240Mbps)?

or it is an impossible to do that?
if it is impossible tell me why please?

thanks in advance
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
