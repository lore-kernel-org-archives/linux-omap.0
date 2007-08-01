From: "Girish" <girishsg@ti.com>
Subject: RE: Keypad Application
Date: Wed, 1 Aug 2007 16:12:53 +0530
Message-ID: <200708011042.l71Agrk6001853@dbdp31.itg.ti.com>
References: <c656a4d20708010028n5b52efb2yb14d36344f9e9924@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c656a4d20708010028n5b52efb2yb14d36344f9e9924@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'arun c' <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>> -----Original Message-----
>> From: linux-omap-open-source-bounces+girishsg=ti.com@linux.omap.com
>> [mailto:linux-omap-open-source-bounces+girishsg=ti.com@linux.omap.com] On
>> Behalf Of arun c
>> Sent: Wednesday, August 01, 2007 12:59 PM
>> To: linux-omap-open-source@linux.omap.com
>> Subject: Keypad Application
>> 
>> Hi all,
>> 
>> I want to write an application which will be using the keypad of
>> omap2430SDP.
>> 
>> can anybody tell me what driver interface i must use in my application??.
>> The name of the device in /dev dir will be enough for me.
>> 
>> whether the keypad driver in SDP is an event driver ??

you have to make sure that while building the kernel, event interface is
selected in menuconfig under input device support.

>> 
>> Best regards,
>> Arun
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
