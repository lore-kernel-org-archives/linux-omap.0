From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] OMAP2 camera and TCM825x sensor drivers
Date: Wed, 28 Feb 2007 10:39:13 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C475C9521@dlee13.ent.ti.com>
References: <45E5A489.2040108@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45E5A489.2040108@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

If some patches are for review please mark them as "RFC". "Patch" is
when it has to go into tree - Some one can correct me if I am wrong.

Sakari,

Thanks for the code, do you have any kind of design doc or ppt that
gives a brief overview of what the code is and the interface considered
etc. Its bit hard to go directly to code :(

The second issue is merging TI's camera code with this. I can post our
design considerations for camera. We can see how to integrate TIs sensor
and additional functionality provided by TI's camera code (like
rotation, scatter gather dma, multiple sensors handling etc).

Please do comment if you find any issues with the same.

Regards,
Khasim

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of Sakari Ailus
>Sent: Wednesday, February 28, 2007 9:49 AM
>To: linux-omap-open-source@linux.omap.com
>Subject: [PATCH] OMAP2 camera and TCM825x sensor drivers
>
>Hi,
>
>I'm about to send a patch set of OMAP 2 camera and a TCM825x sensor
>drivers. Compared to those from maemo.org, there are clean-ups and the
>overlay support has been removed, among other things.
>
>This is all still very much work in progress but I'd be glad to hear
>comments about it.
>
>Both drivers should compile, and also function with 2.6.18 from
>maemo.org. (Except that there's a bug in VIDIOC_DQBUF in 2.6.18.) Some
>N800-specific code is missing for the moment. Also locking is in sore
>state. The interface changes (temporarily) break existing OMAP 1 camera
>driver and the ov9640 sensor driver.
>
>These patches are against Tony's tree.
>
>I recommend not to apply these for the time being. :)
>
>Regards,
>
>--
>Sakari Ailus
>sakari.ailus@nokia.com
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
