From: Timothy Tang <ttang@ktrc-na.com>
Subject: RE: Problem with McSPI as Slave
Date: Wed, 18 Jul 2007 18:25:33 -0700
Message-ID: <4.3.2.7.2.20070718181421.01febf80@fantasia.intra.kyocera-wireless.com>
References: <4.3.2.7.2.20070717115551.01febf80@fantasia.intra.kyocera-wireless.com>
	<4.3.2.7.2.20070717115551.01febf80@fantasia.intra.kyocera-wireless.com> <E6CCDC65B8C522458685D8D1F145FEA8975C8F@CA2-MSX-C01.nw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <E6CCDC65B8C522458685D8D1F145FEA8975C8F@CA2-MSX-C01.nw.net>
References: <4.3.2.7.2.20070717115551.01febf80@fantasia.intra.kyocera-wireless.com>
	<4.3.2.7.2.20070717115551.01febf80@fantasia.intra.kyocera-wireless.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Krishna Prasad Herur <kherur@nextwave.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Herur,

It was a pin muxing problem. Please see my reply to Khasim for details.
The cable I use is about 20 inches long, but I don't seem to have any
problem with that.  I did slow down the clock a notch though to make the signal
more robust.

It is an interesting idea to do loop back between two controllers on the same
processor, I will give that a try once I can get the two board solution to 
work.

Best regards,
Tim

At 04:12 PM 7/18/2007 -0700, Krishna Prasad Herur wrote:
>I have had an issue with the length of the cable used to drive the
>slave. The Omap2430 Spi master was not able to drive an external SPI
>slave when my cable was longer than 10-12 inches.
>
>Have you tried looping back data from one SPI instance to the other on
>the same processor?
>-Prasad
>
>
>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com
>[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
>Timothy Tang
>Sent: Tuesday, July 17, 2007 3:53 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: Problem with McSPI as Slave
>
>Hi All,
>
>I am trying to establish SPI communication between two 2430sdp boards.
>I
>have configured one board as master and
>the other as slave.  Both master and slave use McSPI3 channel 0 (Only
>channel 0 can be used as slave) and they are
>physically connected via SPI bus as shown below:
>
>Master                         Slave
>======================
>CS0     ----------------------  CS0
>SCLK   ----------------------  SCLK
>MOSI   ----------------------  MOSI
>MISO   ----------------------  MISO
>GND    ----------------------  GND
>
>Both master and slave run the 2.6.22rc5 kernel from the MontaVista git
>tree.  For the master, the default omap2_mcspi
>master controller driver is used.  The only change made to the master
>driver is to deactivate CS0 between SPI words
>as required by the slave.  For the slave, I had to change the default
>driver to configure McSPI3 as slave by setting
>the MS bit to 1 in McSPI3's module control register.  I also configured
>MOSI as input and MISO as output for the slave.
>Both master and slave use polling and programmed I/O and they are
>configured with identical SPI bus parameters such
>as CS polarity and mode.
>
>When both master and slave are up running, the master transmits the same
>
>word to the slave continuously.  The slave
>keeps polling the RXS bit in the McSPI3.Ch0 channel status register to
>check if a word has been received or not.
>
>The master works fine, generating the correct waveforms on the SPI
>bus.  The problem is that the slave was not able to
>receive any thing from the SPI bus.  The slave always timed out waiting
>for
>the RXS bit to set, even with a very long time
>out period.
>
>I have verified the physical connections between the two boards and they
>
>are definitely connected correctly.
>
>I am not sure why the slave was not able to detect the signals generated
>by
>the master and I don't know what is the best
>way of debugging this issue.
>
>Has anyone successfully made McSPI working as slave on 2430sdp?  Any tip
>to
>help me debug this issue will be highly
>appreciated.
>
>Best regards,
>Timothy Tang
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
