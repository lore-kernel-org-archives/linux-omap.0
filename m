From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Wed, 3 Jul 2013 14:56:27 -0500
Message-ID: <51D481EB.5030902@ti.com>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
	<51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
	<51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
	<20130702121345.GL27646@sirena.org.uk>
	<51D3EA42.3040205@metafoo.de>
	<20130703094307.GE27646@sirena.org.uk> <51D4245F.8070307@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51D4245F.8070307-Oq418RWZeHk@public.gmane.org>
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
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On 07/03/2013 08:17 AM, Mike Looijmans wrote:
> On 07/03/2013 11:43 AM, Mark Brown wrote:
>> On Wed, Jul 03, 2013 at 11:09:22AM +0200, Lars-Peter Clausen wrote:
>>> On 07/02/2013 02:13 PM, Mark Brown wrote:
>>
>>>> This sort of cyclic thing tends to be best, ideally you don't need
>>>> interrupts at all (other than a timer).
>>
>>> Yes, this is usually how it is done. But I'm wondering maybe the EDMA
>>> controller only has a small total amount of slots available.
>>
>> Well, you don't need particularly many slots so long as you can cope
>> with a large period size.
> 
> On the OMAP L138, there are 128 PARAM slots. 32 of those are tied to hardware
> events (though you can use them if you aren't using the related hardware, for
> example the UART drivers don't use DMA so you can freely use those slots if you
> want), leaving (at least) 96 PARAM slots free. Both audio events are on the same
> controller, so you can't use the 128 of the other one (the OMAP has 2 EDMA
> controllers). Only a few dozen of those are being used by various drivers, the
> SD card driver being the most hungry.
> For the system to work, you can even get away with only using one slot, and
> hence one period, but then you'll have to use a mmap and a timer to fill it.
> 
> I experimented with various memory layouts. For large transfers, using 2 big
> periods was quite enough. I also tested with very small period sizes. Using the

Wouldn't very small periods take up too many interrupts, and also occupy lots of
slots?

> original code, I was unable to reliably capture (to /dev/null) at period sizes
> below 80 samples. With the cyclic DMA, I could set a period size of only 40
> samples and still be able to record audio reliably, when using only 8 periods.
> The same for playback, basically. So that's how I arrived at the MAX_PERIODS
> define of "8". It will only claim channels when you use them, so setting it to
> say "100" will not crash the system.

Thanks for your post Mike. It makes more sense to me now.
Correct me if I'm wrong but:
- more the periods, more the granularity- but the drawback is you'd need more
slots and too many interrupts; so we want fewer periods as many as we need. I
still don't know though, how do we arrive at an acceptable number that userspace
expects?
- periods also will determine buffer size. Considering in future if we'd want to
use IRAM as the buffer which is limited on some users of the davinci-pcm, there
might not be enough buffer space.

So too many periods is certainly not a good thing. I wonder how we can arrive at
what would constitute an acceptable number? As Linus said, "we never break
userspace :P" so I'd rather not change anything that breaks someone's audio
application.

I will post some RFC notes soon capture our discussion and other ideas I had put
together for EDMA as some notes to summarize and get everyone's opinion. I will
copy you on that as well. Thanks.

-Joel
