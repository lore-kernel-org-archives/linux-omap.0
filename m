From: "Amit Gupta" <amitjobs05@gmail.com>
Subject: FSUSB Port 0 in OAMP2430 SDP
Date: Sun, 5 Aug 2007 01:07:44 +0530
Message-ID: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi

Thanks for the series of prompt replies.

I am still struck up in the code. I have gonr through the code of
isp1301_omap.c.
The Vbus_drv bit has already been set in the linux code in the
isp1301_set_host() in the following statement :-

isp1301_set_bits(isp, ISP1301_OTG_CONTROL_1, OTG1_VBUS_DRV);

So this means the care has already been taken care of setting the Vbus
to 5 volts.
And as per the statement above this line states the care has already
been taken care
of using mini A plug /mini B plug in the mini AB receptacle.

So the question arises that why is my port not getting powered up.
I am not sure what exactly needs to be done if I want to configure the
FSUSB port 0 as host port only since I am not aware of the OTG
configuratins/state machines.
And i am not sure how ISP1301_omap.c takes care of the host , device
and OTG configurations seperately.

Can any one suggest me settings I need to do within the ISP-1301 for
OMAP to act as host only since my OMAP gost controller is already
configured and is sending SOF interrupt messages but my port is not
getting powered up.

Also kindly tell me the current capablity support for the port. Will
it be able to power up the USB mouse.

Also how are the connections for FSUSB port 1 . Are they through
ISP-1301 transceiver only ?

Thanks & Regards

Amit
