From: Laurent Epinat <laurent.epinat@cioinfoindus.fr>
Subject: Re: Trying to understand how to use new OMAP mux code
Date: Thu, 03 Jun 2010 15:42:14 +0200
Message-ID: <4C07B136.8010008@cioinfoindus.fr>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>	<20100311224812.GU2900@atomide.com>	<4C062DD4.2050701@cioinfoindus.fr>	<20100602112130.GG5980@atomide.com> <20100602144606.4287c438.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out04.msg.oleane.net ([62.161.7.2]:33528 "EHLO
	smtp-out04.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261Ab0FCOCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 10:02:16 -0400
Received: from smtp05.msg.oleane.net (smtp05.mail.priv [172.17.20.114])
	by smtp-out04.msg.oleane.net with ESMTP id o53E2De5004870
	for <linux-omap@vger.kernel.org>; Thu, 3 Jun 2010 16:02:14 +0200
In-Reply-To: <20100602144606.4287c438.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>

Le 02.06.2010 13:46, Jarkko Nikula a =E9crit :
> On Wed, 2 Jun 2010 14:21:30 +0300
> Tony Lindgren<tony@atomide.com>  wrote:
>
>>> How can I call  omap_mux_init_signal()
>>> from external driver compiled as module ?
>>>
>>> cause the function is not in the standard path include files
>>> and is not exported
>>
>> You can't that's the whole idea :)
>>
>> Instead, please do the muxing in the board-*.c file for all the
>> pins, or for the device when you initialize the platform data.
>>
>> The muxing of pins is board specific, and doing it in the board-*.c
>> files allows us to free the memory for the unused pin data. Note
>> that you can also mux using the kernel cmdline if you have something
>> non-standard connected to your board pins.
>>
> Side note.
>
> How about add-on cards for e.g. BeagleBoard? It would be nice feature
> if a kernel module for that particular add-on card can do the muxing
> without needing to specify them on cmdline. I.e. if you are switching
> between cards there is no need to figure out new cmdline for each of
> them. For me even "rootwait" is sometimes too difficult to remember :=
-)
>
>

The thing is

We make Computer-On-Modules

http://www.cioinfoindus.fr/fr/produits/computer-on-module-maia.html


and we make the support board for them according to the extra functiona=
lites required
eg: for some boards we need i2c2 and for others we need gpio (168,183)


I would like one basic configuration for the modules with (twl,net,flas=
h,.. all on the COM's)
and for the rest, external driver for extra functionalities on the supp=
ort board.

This is why I need to change the mux pins dynamically by the driver mod=
ule.




--=20

Salutations
Laurent Epinat -> mailto:laurent.epinat@cioinfoindus.fr

CIO Informatique
Le millenium
1, rue de Presse - BP 710
42950 Saint-Etienne Cedex 9

Tel    33 (0) 477 93 34 32
Tcopie 33 (0) 477 79 75 55
WWW : http://www.cioinfoindus.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
