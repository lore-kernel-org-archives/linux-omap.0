From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: SMBus Quick command not supported, can't probe for chips
Date: Fri, 29 Dec 2006 15:30:30 +0100
Message-ID: <45952686.4090509@gmail.com>
References: <25c21ceb0612281250n7ecfb240pa487c392a866b5c7@mail.gmail.com>
	<25c21ceb0612290321y3423759ev4d3cdc600fdae1cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <25c21ceb0612290321y3423759ev4d3cdc600fdae1cc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?ISO-8859-1?Q?Ragner_N_Magalh=E3es?= <ragner@users.sourceforge.net>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Ragner N Magalh=E3es wrote:
>> ...
>> i2c-core: driver [isp1301_omap] registered

Does this mean my isp1301 fix works for you? Do you tested=20
my ISP1301 and board-h3 fixes?

...
>> i2c_adapter i2c-0: SMBus Quick command not supported, can't probe for
>> chips
...

For this you can try

http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/00823=
2.html

until I2C is fixed upstream.

Dirk
