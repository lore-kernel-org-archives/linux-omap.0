From: Laurent Epinat <laurent.epinat@cioinfoindus.fr>
Subject: Re: Trying to understand how to use new OMAP mux code
Date: Wed, 02 Jun 2010 12:09:24 +0200
Message-ID: <4C062DD4.2050701@cioinfoindus.fr>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com> <20100311224812.GU2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out06.msg.oleane.net ([62.161.7.4]:35287 "EHLO
	smtp-out06.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab0FBOQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 10:16:48 -0400
Received: from smtp04.msg.oleane.net (smtp04.mail.priv [172.17.20.113])
	by smtp-out06.msg.oleane.net with ESMTP id o52ATepO021893
	for <linux-omap@vger.kernel.org>; Wed, 2 Jun 2010 12:29:40 +0200
In-Reply-To: <20100311224812.GU2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hello all


How can I call  omap_mux_init_signal()
from external driver compiled as module ?

cause the function is not in the standard path include files
and is not exported

regards,

Laurent

Le 11.03.2010 23:48, Tony Lindgren a =E9crit :
> * Peter Barada<peter.barada@gmail.com>  [100311 14:29]:
>> 1) Suppose I want to talk to a bluetooth chip through UART2.  UART2_=
TX
>>   gives me a choice of pins to hook up to, either to pin AA26 in Mod=
e0,
>> or pin AF5 in Mode1.  If I use omape_mux_init_signal("uart2_tx",
>> OMAP_PIN_OUTPUT), which pin will that map to?
>
> You need to check the omap package type you're using to find
> out the correct ball name. If you get lucky, that's already in
> mux34xx.c and you don't need search through the TRMs :)
>
>> 2) How can I tell the muxing code that I want a specific pin for my
>> UART2_TX signal (that's not a GPIO since those can be directly
>> specified by GPIO number)?
>
> Then you want to use the full signal name:
>
> omap_mux_init_signal("mode0_name.desired_mode", OMAP_PIN_FLAGS)
>
> But as the balls can be separate for each package type, you
> need to figure that out first.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


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
