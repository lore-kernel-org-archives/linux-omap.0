From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] Query on Audio DMA using DMAEngine
Date: Thu, 4 Jul 2013 16:29:53 +0530
Message-ID: <51D555A9.5030500@ti.com>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
	<51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
	<51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
	<20130702121345.GL27646@sirena.org.uk>
	<51D3EA42.3040205@metafoo.de>
	<20130703094307.GE27646@sirena.org.uk>
	<51D46598.6070005@ti.com> <51D510EA.1030809@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51D510EA.1030809-Oq418RWZeHk@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 7/4/2013 11:36 AM, Mike Looijmans wrote:
> On 07/03/2013 07:55 PM, Joel Fernandes wrote:
>> Copying some more lists are we're also discussing the DMA controller
>> in the
>> SoCs. Thanks.
>>
>> On 07/03/2013 04:43 AM, Mark Brown wrote:
>>> On Wed, Jul 03, 2013 at 11:09:22AM +0200, Lars-Peter Clausen wrote:
>>>> On 07/02/2013 02:13 PM, Mark Brown wrote:
>>>
>>>>> This sort of cyclic thing tends to be best, ideally you don't need
>>>>> interrupts at all (other than a timer).
>>>
>>>> Yes, this is usually how it is done. But I'm wondering maybe the EDMA
>>>> controller only has a small total amount of slots available.
>>>
>>> Well, you don't need particularly many slots so long as you can cope
>>> with a large period size.
>>
>> Hi Mark,
>>
>> When would it not be possible to cope with a large period size? Are
>> there any
>> guidelines on what to consider when fixing a period size?
>>
>> I see tegra and aux1x go upto .period_bytes_min = 1024
>>
>> About slots, following are no.of slots on some SoCs with EDMA:
>>
>> am1808 - 96 slots available + 32 taken up for channel but can be
>> reused with
>> some changes.
>> am335x - 172 slots available + 64 taken up for channels
>>
>> On a slightly different note, about buffer_bytes_max, is there any
>> drawback to
>> setting it to a smaller value? Currently 128K is about what is used on
>> davinci-pcm.
>> My idea is to map to do the direct mapping to IRAM if the IRAM
>> transfers are
>> really what are preventing the under runs, but 128K will be too much
>> for the
>> buffer as we don't have that much IRAM infact it is just the boundary
>> on am33xx
>> (128K)
> 
> In any case, using the IRAM directly might have some use, because you
> don't have to compete for the DDRRAM with other devices. But I never
> understood what the ping-ping via IRAM was supposed to accomplish, I
> don't see why McASP -> IRAM -> DDRRAM (or the other way around) would be
> better than just McASP -> DDRRAM. Especially since the McASP has a
> built-in 256 byte FIFO buffer on both channels. In all my measurements,
> using the IRAM ping-pong only made things worse in terms of overruns and
> underruns, not better.
> 
> Anyone who know why the ping-pong was implemented and what kind of usage
> it was intended for?

McBSP peripheral that was included in the DaVinci devices like DM644x
dis not come with FIFO. Due to latency of DDR accesses, there were
channel swaps observed due to lost samples on these devices and IRAM
implementation helped there.

Thanks,
Sekhar
