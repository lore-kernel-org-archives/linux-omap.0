From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: regarding bootloaer
Date: Sat, 11 Nov 2006 08:33:02 +0100
Message-ID: <45557CAE.6000203@gmail.com>
References: <7AF192DA69C59243838FF62851F64F550321202C@toebe101.NOE.Nokia.com>	<20061108110204.74677.qmail@web34906.mail.mud.yahoo.com>
	<8028e5750611090704o2b19bf4cvdf00cb13cdb275e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <8028e5750611090704o2b19bf4cvdf00cb13cdb275e2@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Romain Goyet <r.goyet@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Romain Goyet wrote:
> Allrifght Rajesh, you should first tell us to which kind of plateform
> you're porting Linux to. Actually, "porting linux to OMAP1510" makes
> virtually no sense, given that the port is already done and totally
> functionnal.

For that matter, seems that 
drivers/input/keyboard/innovator_ps2.c used on Innovator 
1510 is broken:

   CC [M]  drivers/input/keyboard/innovator_ps2.o
drivers/input/keyboard/innovator_ps2.c: In function 
'innovator_kbd_init':
drivers/input/keyboard/innovator_ps2.c:1225: warning: 
implicit declaration of function 'init_input_dev'

WARNING: "init_input_dev" 
[drivers/input/keyboard/innovator_ps2.ko] undefined!

Cheers

Dirk

> 2006/11/8, rajesh B <trytorajesh@yahoo.com>:
> 
>> Hi,
>> Am using rrload bootloader for porting linux in OMAP1510, am structing 
>> with some problem in loading in this booloader so any any help me with 
>> some other bootloader suppoerting for OMAP1510...
>>
>>
>> bye
>>
>>
>> rajesh.B
>>
>> ---------------------------------
>> Sponsored Link
>>
>> Try Netflix today! With plans starting at only $5.99 a month what are 
>> you waiting for?
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
