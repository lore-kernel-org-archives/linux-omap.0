From: "Girish" <girishsg@ti.com>
Subject: RE: Problem with McSPI as Slave
Date: Wed, 18 Jul 2007 10:59:09 +0530
Message-ID: <200707180529.l6I5T9Ih019984@dbdp31.itg.ti.com>
References: <4.3.2.7.2.20070717115551.01febf80@fantasia.intra.kyocera-wireless.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4.3.2.7.2.20070717115551.01febf80@fantasia.intra.kyocera-wireless.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Timothy Tang' <ttang@ktrc-na.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Some comments embedded bellow.

 

Regards,

girish

 

>> -----Original Message-----

>> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-

>> open-source-bounces@linux.omap.com] On Behalf Of Timothy Tang

>> Sent: Wednesday, July 18, 2007 4:23 AM

>> To: linux-omap-open-source@linux.omap.com

>> Subject: Problem with McSPI as Slave

>> 

>> Hi All,

>> 

>> I am trying to establish SPI communication between two 2430sdp boards.  I

>> have configured one board as master and

>> the other as slave.  Both master and slave use McSPI3 channel 0 (Only

>> channel 0 can be used as slave) and they are

>> physically connected via SPI bus as shown below:

>> 

>> Master                         Slave

>> ======================

>> CS0     ----------------------  CS0

>> SCLK   ----------------------  SCLK

>> MOSI   ----------------------  MOSI

>> MISO   ----------------------  MISO

>> GND    ----------------------  GND

 

Did you made sure the correct muxing of pins? You need to check that first.

>> 

>> Both master and slave run the 2.6.22rc5 kernel from the MontaVista git

>> tree.  For the master, the default omap2_mcspi

>> master controller driver is used.  The only change made to the master

>> driver is to deactivate CS0 between SPI words

>> as required by the slave.  For the slave, I had to change the default

>> driver to configure McSPI3 as slave by setting

>> the MS bit to 1 in McSPI3's module control register.  I also configured

And also have you taken care of single/multi channel bit in module control? 

 

>> MOSI as input and MISO as output for the slave.

>> Both master and slave use polling and programmed I/O and they are

>> configured with identical SPI bus parameters such

>> as CS polarity and mode.

>> 

>> When both master and slave are up running, the master transmits the same

>> word to the slave continuously.  The slave

>> keeps polling the RXS bit in the McSPI3.Ch0 channel status register to

>> check if a word has been received or not.

>> 

>> The master works fine, generating the correct waveforms on the SPI

>> bus.  The problem is that the slave was not able to

>> receive any thing from the SPI bus.  The slave always timed out waiting

>> for

>> the RXS bit to set, even with a very long time

>> out period.

>> 

>> I have verified the physical connections between the two boards and they

>> are definitely connected correctly.

>> 

>> I am not sure why the slave was not able to detect the signals generated

>> by

>> the master and I don't know what is the best

>> way of debugging this issue.

You might check the data transfer vice-versa with the same set-up, i.e.,
sending word from slave to master. And check if slave is able to transmit
and generate wave forms as expected. 

>> 

>> Has anyone successfully made McSPI working as slave on 2430sdp?  Any tip

>> to

>> help me debug this issue will be highly

>> appreciated.

Even we had faced some problems testing master/slave in polling mode;
actually we can't rely on wires connecting externally. 

 

>> 

>> Best regards,

>> Timothy Tang

>> 

>> _______________________________________________

>> Linux-omap-open-source mailing list

>> Linux-omap-open-source@linux.omap.com

>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
