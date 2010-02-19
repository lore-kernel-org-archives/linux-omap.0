From: <ext-Eero.Nurkkala@nokia.com>
Subject: Re: [PATCHv4 2/2] ASoC: OMAP-McBSP: ASoC interface for
 McBSP sidetone
Date: Fri, 19 Feb 2010 20:03:48 +0100
Message-ID: <1FFEF31EBAA4F64B80D33027D42977602143ED8FEF@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266518549-23809-2-git-send-email-ilkka.koskinen@nokia.com>,
	<1266518549-23809-3-git-send-email-ilkka.koskinen@nokia.com>
	<1FFEF31EBAA4F64B80D33027D42977602143ED8FED@NOK-EUMSG-02.mgdnok.nokia.com>,
	<alpine.DEB.2.00.1002191355450.3039@tumpelo.nmp.nokia.com>
	<1FFEF31EBAA4F64B80D33027D42977602143ED8FEE@NOK-EUMSG-02.mgdnok.nokia.com>,
	<F80267346F10C541946CBE8909F1C39E26A47EBD9C@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <F80267346F10C541946CBE8909F1C39E26A47EBD9C@NOK-EUMSG-02.mgdnok.nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ilkka.koskinen@nokia.com
Cc: alsa-devel@alsa-project.org, tony@atomide.com, eduardo.valentin@nokia.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> Oops, I seemed to copy Q1.14 instead of Q14.1, but isn't it still the same.
> When I added some debug messages it still seemed to be corret.
> 
> Lowest number (-32768) is represented with 16th bit '1' and the rest are
> zeros, right? That is 0x8000.
> -1 has all the bits set (0xffff) and 0 has all the bit cleared (0x0000).
> Highest positive value has 16th bit cleared and the rest set (0x7fff).
> 
> Or did I interpret something wrong?
> 
> Cheers, Ilkka

I guess it's just fine, but let's see. Maybe I was lost in the Q1.14: m + n + 1 ~
binary: [sign bit, (m), (n)] where m is the integer portion, 0 or 1, n is 14 bits..
so  if your input was [-32768... 32767] -> [-2,2] then, for example,
-32768 is in hex: 0x8000, but the 2nd most significant bit is zero, which means
the integer portion (m) is not 1, which makes me doubt the gain -32768 is
actually -1 (or 0), not -2. But then, as it's a two's complement, it maybe just correct.

So most likely it's just fine; I just had a thinko.

- Eero
