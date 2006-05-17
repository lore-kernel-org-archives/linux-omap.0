From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: SPI edge selection [was Re: Edge selecton
 on SPI bus]
Date: Wed, 17 May 2006 13:13:51 +0300
Message-ID: <446AF75F.4080005@nokia.com>
References: <1147691115.32613.10.camel@mammoth.research.nokia.com>
	<200605151159.37793.david-b@pacbell.net>
	<1147817569.27886.54.camel@mammoth.research.nokia.com>
	<200605161950.17041.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605161950.17041.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

ext David Brownell wrote:
>> I think the devices worked so far with this buggy logic since I suspect
>> a complementary problem in the TRM for the read edge selection HW flag.
>> I checked this against devices that are known to be using a given SPI
>> mode.
> 
> Hmm, I hope the attached GIF makes it through ... it shows the data
> and clock signals and their variations pretty clearly, though you need
> to understand that "out" means MOSI.

 From the diagram it seems that the master will shift out the data on 
MOSI at the same time as it is latching in the data on MISO. If that's 
really the case, then as I understand the loopback setup (connecting the 
two lines) wouldn't be possible. Also CPHA would define only the mode on 
the MOSI line, the MISO line would operate according to the opposite 
semantic. This might be the case, though I haven't found a description 
where this distinction was pointed out.

> 
> Agreed, the TRM is a bit opaque there.  There are three bits to
> cover two basic protocol options:  sample edge (2x) which seems
> to encode CPHA, and clock polarity which sure ought to be CPOL.  

Yes, so the 2 edge flags should always be set to the same value to 
define a valid SPI mode.

Also in OMAP2 the SPI PHA flag is defined to be the opposite value of 
the CPHA as defined in the four SPI modes.

> 
> 
>> Also at least the ads7846 was using incorrectly SPI mode 0, since it's
>> expecting writes on the falling / reads on the rising edge which maps to
>> mode 1.
> 
> Seems right ... does that give you more consistent sample readings?

No, setting to mode 1 won't change the actual HW configuration, since 
with the uWire patch the mapping also changes to set the same HW flags 
as we used before.

--Imre

> 
> 
>> I'm posting 3 patches to solve these issues.
> 
> They look OK to me.  I'd say to merge them to the OMAP tree; if no
> problems turn up, I'll push the ads7846 patch along soonish.
> 
> - Dave
> 
> 
> ------------------------------------------------------------------------
> 
