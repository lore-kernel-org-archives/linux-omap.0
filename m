From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: TSC2101/2102
Date: Wed, 14 Mar 2007 21:35:36 +0100
Message-ID: <45F85C98.1080506@googlemail.com>
References: <20070309140650.GC4399@bitbox.mine.nu>	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>	<45F7F6D4.20203@gmail.com>
	<20070314170952.GB10230@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070314170952.GB10230@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@solidboot.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Imre Deak wrote:
> On Wed, Mar 14, 2007 at 08:21:24AM -0500, Nishanth Menon wrote:
> 
>>andrzej zaborowski stated on 3/9/2007 8:23 AM:
>>
>>>On 09/03/07, Imre Deak <imre.deak@solidboot.com> wrote:
>>>
>>>>I'm wondering about the proper way to convert the existing omap-tsc2101
>>>>driver to the SPI framework. Would it make sense to handle it with the
>>>>tsc2102 driver? omap-tsc2101 has only the register read / write
>>>>interface
>>>>which is the same as in tsc2102.
>>>
>>>How about maybe a header file <linux/spi/tsc2xxx.h> shared between
>>>tsc2101/2102 with the register access functions as "static inline"
>>>functions?
>>
>>Some TODOs:
>>1. should interrupt muxing be done here?
>>2. There are some TSC2005 devices(TS only).. so it will be interesting
>>to see xxxx.h scales to all..
>>3. rename this to tsc2xxx_core.[ch]
>>4. use SPI framework (would not break uwire support I believe).
> 
> 
> The attached patches try to do #4. Please review it / sign it off as
> necessary.

Great! Many thanks.

Is this already sufficient to remove 
drivers/ssi/omap-tsc2101.[ch]? If yes, I would propose to 
apply this to get rid of tsc in ssi directory as fast as 
possible. And, in parallel, we can use this as starting 
point for further improvements as mentioned above.

Dirk
