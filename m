From: "Bhaskara Rao Kotla" <bhaskar12@gmail.com>
Subject: need help in finding the issue with open source kernel
Date: Fri, 5 Jan 2007 11:31:17 -0600
Message-ID: <1c5b04b60701050931r1fd235f3rfebdf3a8f9fa1f45@mail.gmail.com>
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

Hi,
    I am trying to use open source kernel and u-boot from the below location
on OMAPSDP 2430 version 2.9 board.
    http://linux.omap.com/pub/
    I used gcc-3.4.0-1 version compiler to build kernel as well as u-boot.
    I could able to build kernel and u-boot successfully and flash the
u-boot with NOR option on the board using CSST tool BOOTROM mode.

    Now I am trying to load the kernel on the board, but it seems not going
forward. it got stuckup like below



Bytes transferred = 1415409 (1598f1 hex)
OMAP243X SDP # bootm
## Booting image at 80300000 ...
   Image Name:   Linux Kernel Image
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1415345 Bytes =  1.3 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ..........

I would appreciate if someone can help me in finding the issue?

Thanks and Regards,

Bhaskara
