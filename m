From: <ilkka.koskinen@nokia.com>
Subject: RE: [PATCHv4 2/2] ASoC: OMAP-McBSP: ASoC interface for McBSP
 sidetone
Date: Mon, 22 Feb 2010 12:11:32 +0100
Message-ID: <F80267346F10C541946CBE8909F1C39E26A8E07AC1@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
 <1266518549-23809-2-git-send-email-ilkka.koskinen@nokia.com>,<1266518549-23809-3-git-send-email-ilkka.koskinen@nokia.com>
 <1FFEF31EBAA4F64B80D33027D42977602143ED8FED@NOK-EUMSG-02.mgdnok.nokia.com>,<alpine.DEB.2.00.1002191355450.3039@tumpelo.nmp.nokia.com>
 <1FFEF31EBAA4F64B80D33027D42977602143ED8FEE@NOK-EUMSG-02.mgdnok.nokia.com>,<F80267346F10C541946CBE8909F1C39E26A47EBD9C@NOK-EUMSG-02.mgdnok.nokia.com>
 <1FFEF31EBAA4F64B80D33027D42977602143ED8FEF@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43078 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab0BVLMk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 06:12:40 -0500
In-Reply-To: <1FFEF31EBAA4F64B80D33027D42977602143ED8FEF@NOK-EUMSG-02.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-Eero.Nurkkala@nokia.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com, eduardo.valentin@nokia.com

 

>From: Nurkkala Eero.An (EXT-Offcode/Oulu) 
>Sent: 19 February, 2010 21:04
>
>> Oops, I seemed to copy Q1.14 instead of Q14.1, but isn't it 
>still the same.
>> When I added some debug messages it still seemed to be corret.
>> 
>> Lowest number (-32768) is represented with 16th bit '1' and 
>the rest are
>> zeros, right? That is 0x8000.
>> -1 has all the bits set (0xffff) and 0 has all the bit 
>cleared (0x0000).
>> Highest positive value has 16th bit cleared and the rest set 
>(0x7fff).
>> 
>> Or did I interpret something wrong?
>> 
>> Cheers, Ilkka
>
>I guess it's just fine, but let's see. Maybe I was lost in the 
>Q1.14: m + n + 1 ~
>binary: [sign bit, (m), (n)] where m is the integer portion, 0 
>or 1, n is 14 bits..
>so  if your input was [-32768... 32767] -> [-2,2] then, for example,
>-32768 is in hex: 0x8000, but the 2nd most significant bit is 
>zero, which means
>the integer portion (m) is not 1, which makes me doubt the 
>gain -32768 is
>actually -1 (or 0), not -2. But then, as it's a two's 
>complement, it maybe just correct.
>
>So most likely it's just fine; I just had a thinko.

Ok, now I got your point :) However, as far as I can understand
the Q notation right, it basically defines how to interpret the 
value. That is, where is the decimal point. Thus, I would say that
the code should work fine and based on quick tests, the gain control
seems to behave ok too.

Cheers, Ilkka