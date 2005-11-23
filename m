From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Wed, 23 Nov 2005 17:10:03 +0100
Message-ID: <4384945B.7050700@de.bosch.com>
References: <42848A5C5A0D1E47B026E644DD49B08E683708@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <42848A5C5A0D1E47B026E644DD49B08E683708@mail>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Yves Godin <Yves.Godin@lyrtech.com>
List-Id: linux-omap@vger.kernel.org

Yves Godin wrote:
> 	It seems that something has change in the driver for the DMA in
> 2.6.14-omap2.
> 
> When I play a pure tone (ALSA driver), I ear some glitches in the audio
> every 5-10 secconds. Everithing was correct with 2.6.14-rc1.
> 
> From what I can see with a scope on the serial data sent to the codec,
> it seems that some samples (a complete buffer??) are repeated from time
> to time. It's easier to ear it when playing a pure tone (ex 1Khz).
> 
> Note that my alsa driver is slightly modified to play 24 bits audio
> samples instead of 16 bits (DMA is configured in 32 bits). 
> 
> The files from the alsa driver have not changed between 2.6.14-rc1 and
> 2.6.14-omap2. So I supposed the changes have been made to the OMAP dma
> drivers.

On 2.6.15-rc2-omap1 on OSK I can reproduce this using madplay and mp3. 
All 5-10 seconds a short part is repeated.

Any news or ideas about this?

Thanks

Dirk
