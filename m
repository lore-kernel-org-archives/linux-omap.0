From: Liem Pham Tan <tanliemph@gmail.com>
Subject: =?utf-8?q?Process_32-bit_data_without_endianess-conversion_betwe?=
 =?utf-8?b?ZW4gQVJNIOKAkyBEU1A/?=
Date: Tue, 10 Oct 2006 12:14:43 +0700
Message-ID: <452B2C43.9010508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,
I=E2=80=99m using DSP/BIOS LINK 1.10.1 to communicate between ARM and DSP=
 on=20
OMAP5912.
I need to process 32-bit data on both ARM and DSP. The problem is DSP=20
uses big-endian and ARM uses little-endian.
The application note =E2=80=9CUsing Endianess Conversion in the OMAP5912 =
device=E2=80=9D=20
(SWPA027) stated that :  if both MPU and DSP access the data using the=20
same access size, then no endianess conversion is needed.
But when I pass data between them, the DSP always perform an=20
word-endianess conversion (16-bit). For example : If I write 0x00000001=20
on GPP and send via DSP/BIOS LINK to DSP, the data on DSP will be read=20
0x00010000 (and vice versa). I used Int32 on GPP and long on DSP=20
(32-bit) to access the buffer.
The DSP endianess can be controlled by the DSP MMU endianess control=20
register, but I can=E2=80=99t find any good way to set this register in D=
SP/BIOS=20
LINK ( I did try to set the channel attribute to ChannelDataSize_32bits*=20
*but it didn=E2=80=99t work).
Do you have any ideas on this problem?
Best regards,
Liem Pham
