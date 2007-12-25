From: "Chandra shekhar" <x0044955@ti.com>
Subject: RE: OMAP2430 I2C Controller
Date: Tue, 25 Dec 2007 11:26:06 +0530
Message-ID: <200712250556.lBP5u7fT008373@dbdp31.itg.ti.com>
References: <7d8fdf6f0712232007w64624e3aoa7523c8cabf8fe9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <7d8fdf6f0712232007w64624e3aoa7523c8cabf8fe9f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Raghunandan Dhongadi' <dk.raghu@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I2C is request based driver. At the end of the probe clocks are disabled and enabled only when a treansfer request comes. 
So if you take a dump of register at the end of probe, Iclk and Fclk will return 0. 

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com 
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> Behalf Of Raghunandan Dhongadi
> Sent: Monday, December 24, 2007 9:37 AM
> To: Linux-omap-open-source@linux.omap.com
> Subject: OMAP2430 I2C Controller
> 
> Hi All,
> 
> I am facing an issue with setting up the i2c-omap controllers 
> on the Linux 2.6.22 kernel. All though the I2C platform 
> registration happens in the board file, and the 
> "driver/i2c/bussess/i2c-omap.c" has the "i2c_probe" function 
> that sets of the Interface and Functional clock, when I do a 
> register dump of the clock registers, The Functional clock of 
> I2C controllers are not enabled.
> 
> clues anyone?
> Thanks in Advance,
> Raghu
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
