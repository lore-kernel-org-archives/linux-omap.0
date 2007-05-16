From: "Josh Ostrander" <jostrand@gmail.com>
Subject: Bridge vs DSP/BIOS Link
Date: Wed, 16 May 2007 09:32:20 -0400
Message-ID: <8f4c83bc0705160632l288fdbdcibdbef525f75c97a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Curious if anyone knows what the difference is between the DSPBridge OMAP
DSP driver and the DSP/BIOS Link driver.  I did see a question posted about
a year ago on this mailing list but sadly there was no response.  This is
what I know:

1) DSPBridge is for GPP <-> DSP communication with software for both the DSP
and GPP to facilitate this connection.

2) DSP/BIOS Link is also for DSP <-> GPP communication but only includes DSP
software?

3) Both high level architectures have a similar structure with the DSPBridge
framework including a few more layers.  They even have the same name for
certain pieces (e.g. Link driver, Processor Manager, etc.)

So I am still trying to figure out what is the real difference between the
two.  My current best guess is that the DSP/BIOS Link driver is just the DSP
side of the DSPBridge driver, but I have had conflicting reports about
this.  I also can not seem to find any info about the DSPBridge on TI's
website, but I do have documentation and source that came with our SDP.  Any
help out there would be appreciated.  Thanks!

-- Joshua O
