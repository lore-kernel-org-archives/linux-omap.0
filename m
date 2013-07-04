From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Thu, 04 Jul 2013 07:56:25 +0200
Message-ID: <51D50E89.5090503@topic.nl>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <20130702121345.GL27646@sirena.org.uk> <51D3EA42.3040205@metafoo.de>
 <20130703094307.GE27646@sirena.org.uk> <51D46598.6070005@ti.com>
 <20130703181226.GY27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130703181226.GY27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/03/2013 08:12 PM, Mark Brown wrote:
> On Wed, Jul 03, 2013 at 12:55:36PM -0500, Joel Fernandes wrote:
>
>> When would it not be possible to cope with a large period size? Are there any
>> guidelines on what to consider when fixing a period size?
>
> This is an application issue not a driver issue.  An application that
> wants low latency may need high resolution information about what
> exactly the hardware is doing.

To get low-latency, the best thing from userspace is to mmap the audio 
buffer, and monitor the position of the DMA transfers. If the driver 
reports the DMA position accurately, you can get latencies of only a few 
samples. I must admit that I know next to nothing about how ALSA works 
in userspace, but that's how DirectSound works, for example. And from 
what I've seen, this is also possible with ALSA.

Even without that - I tried with small periods of only 40 samples, this 
invariably fails on the current driver, with or without the ping-ping. 
Using the cyclic DMA I had no problem using such small periods.

Mike.
