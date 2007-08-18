From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: Re: FSUSB Port 0 in OAMP2430 SDP
Date: Sat, 18 Aug 2007 23:46:56 +0530
Message-ID: <78d6ed630708181116u5cd3d93bqe7e1c4b4bcb57ae9@mail.gmail.com>
References: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com>
	<31e679430708090419j77cf9a60s786f0582fa3af24@mail.gmail.com>
	<78d6ed630708091136u75f83411xb7ee8bcc08870b52@mail.gmail.com>
	<200708171754.45233.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200708171754.45233.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>, "Kamat, Nishant" <nskamat@ti.com>, Felipe Balbi <felipebalbi@users.sourceforge.net>, "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi David/all

Well I tried using the Kernel Linux 2.6.14 code available.

As mentioned before I used FSUSB port 0(J51) on OMAP2430 SDPv4.0 and
tried connecting the USB device (mouse) using the mini B cable,
configuring the OMAP as host in the USB connection.

But the things didn't worked out since on attachment/detachment of
device there were no interrupts. I agree that the code might be
written for the forced host mode.
I have three queries now: -
1.	So how it decides to go in the host mode. Do we need to set in
forcefully by some command before connecting the OMAP to the USB
device runtime? I have already tried building the code for USB host
config and then attaching the USB device.

2.	Now since you are talking about 8 mA of the current, the USB device
will never be powered up with only this much current. It can never act
as host with so less current capability? Even USB mouse requires 100
mA current. Kindly confirm it.

3.	What is the significance of the ID pin at the transceiver end if
all the decisions can be taken at the OMAP end and we can configure
the ISP transceiver accordingly(through I2C). I think the ISP does
some changes based on the ID pin.

Do we have the ISP1301 programmer's manual, which clearly defines
programming the transceiver in the transceiver in the host mode/ or in
the function mode? If possible kindly send it to me.

Also, if possible send the config file of the tested code with FSUSB
port 0 (J51) acted as a host port.

Thanks & Regards

Amit


On 8/18/07, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 09 August 2007, Amit Gupta wrote:
> > But consider the linux isp1301_omap.c, isp1301_set_host function. In
> > this it tries to power up the vbus(setting the vbus_drv), but I
> > suppose mandatory requirement for this is that I have mini A plug is
> > connected since transceiver is having atleast logic to power up the
> > vbus only if it is connected to function on the other end, or else it
> > would not power up the bus just for some breakdown since it should not
> > happen that from both of cable is powered up(5 volts).
>
> As originally written, the ID Pin in the isp1301 driver was ignored
> except in OTG mode.  If the driver was given a host-only config, the
> isp1301 chip was forced into a mode where it provided 8mA VBUS power
> regardless of anything else -- handy if you have no Mini-A cable
> or adapter.  For a peripheral-only config, it was forced into a mode
> where VBUS was never provided.
>
> Latest code shouldn't be *too* different from that, but it might
> not be happy on such current silicon since I don't knwo the last
> time anyone really worked with that fullspeed OTG stuff.
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
