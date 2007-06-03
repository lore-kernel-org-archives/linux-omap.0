From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: Fwd: OMAP 2430 nand/nor booting
Date: Sun, 3 Jun 2007 19:32:19 +0530
Message-ID: <78d6ed630706030702r1480faf5j3af7f1b5b64dd9ce@mail.gmail.com>
References: <78d6ed630706021205t3d8885afv5129f50f4da04548@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630706021205t3d8885afv5129f50f4da04548@mail.gmail.com>
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

Hi

I have been working on OMAP 2430 SDP BSP support.

For sometime I have been trying to port the boot loader image in NAND and
try to get it execute but I haven't been successful in the same.



Just have some basic doubts on flashing of images through NAND/NOR :-

   1. I tried creating a small image in which I do some hardware
initialization and make something print on LCD and throw some characters on
HyperTerminal. I tried executing the same in NOR and it executed
successfully because NOR is of XIP type but when I had reset my board the
image did not executed successfully. This means that NOR code is not being
relocated automatically to the different location by boot ROM code and its
not executing at the NOR location also.



While as per my documents study, it's clear that after reset the code is
relocated from NOR to different location for execution . But why is this not
happening automatically in my case.



   2. When I tried the downloading the same above image (converted into
.ift) in NAND flash , the code id not executed itself. I have given SRAM
addresses as execution address.  I also heard that NAND flash also has some
XIP region.



The logic is clear that NAND and (NOR image after reset) is not executing
until and unless you have copy code to relocate it to SRAM or SDRAM( if
SDRAM has already been initialized prior to relocation).


Kindly tell me that is my above understanding true or Boot ROM code does
copy some part of code because even if we have copy section within the code,
it needs to be executed before the copy actually takes place.

Thanks & Regards

Aman
