From: RENJITH G WARIER P V <RENJITHGWARIER@nestec.net>
Subject: Problem in Running DSP/BIOS sample application in H3 board
Date: Wed, 20 Dec 2006 08:50:26 +0530
Message-ID: <F6E1228667B6D411BAAA00306E00F2A50AE7379D@pdc2.nestec.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,

I have a problem in running the sample application in DSP/BIOS bridge and
hope someone here could help me.

I am trying to build DSP/BIOS Bridge in OMAP H3 Board running on Linux
2.6.9-omap1. I was able to build bridgedriver.ko, and both sides of the
sample application(DSP side in CCs 2.21 and GPP side in linux). I then
copied bridgedriver.ko, bridgedriver.o, strmcopy.out, strmcopy.dof55l(DSP
side executable), installation script and the corresponding
libraries(libbridge.so and libbridge.so.2). Then tried to run the same

 

# ./install_bridge

Using ./bridgedriver.ko

bridgedriver: module license 'Texas Instruments Incorporated' taints kernel.

 

Also created 2 files - input and output so that we could execute
strmcopy.out

 

# ./strmcopy.out 0 input output

Data streaming using Processor-Copy transport.

DSPProcessor_Attach succeeded.

 DSP Image: ./strmcopy.dof55l.

DSPProcessor_Load s

 

And H3 board hangs.

Can anyone please tell me what the problem may be?

 

Thanks in Advance

Renjith G

 

 

 



---------------------------------------------------------------------------
       "This e-mail and any files transmitted with it are for the sole use
of the intended recipient(s) and may contain confidential and privileged
information. If you are not the intended recipient, please contact the
sender by reply e-mail and destroy all copies of the original message.

       Any unauthorized review, use, disclosure, dissemination, forwarding,
printing or copying of this email or any action taken upon this e-mail is
strictly prohibited and may be unlawful."
---------------------------------------------------------------------------
