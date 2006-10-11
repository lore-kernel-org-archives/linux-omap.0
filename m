From: "Liem Pham Tan" <tanliemph@gmail.com>
Subject: Process 32-bit data without endianess conversion between ARM-DSP?
Date: Wed, 11 Oct 2006 17:49:26 +0700
Message-ID: <982282ef0610110349u6813f2c8rc5095756a8534dc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi All,
I'm using DSP/BIOS LINK 1.10.1 to communicate between ARM and DSP on
OMAP5912.
I need to process 32-bit data on both ARM and DSP. The problem is DSP
uses big-endian and ARM uses little-endian.
The application note "Using Endianess Conversion in the OMAP5912 device"
(SWPA027) stated that :  if both MPU and DSP access the data using the
same access size, then no endianess conversion is needed.
But when I pass data between them, the DSP always perform an
word-endianess conversion (16-bit). For example : If I write 0x00000001
on GPP and send via DSP/BIOS LINK to DSP, the data on DSP will be read
0x00010000 (and vice versa). I used Int32 on GPP and long on DSP
(32-bit) to access the buffer.
The DSP endianess can be controlled by the DSP MMU endianess control
register, but I can't find any good way to set this register in DSP/BIOS
LINK ( I did try to set the channel attribute to ChannelDataSize_32bits*
*but it didn't work).
Do you have any ideas on this problem?

-- 
Best regards,

Liem Pham
