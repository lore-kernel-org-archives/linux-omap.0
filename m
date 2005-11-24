From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Audio L/R Channel Interchanges ( Solved!)
Date: Thu, 24 Nov 2005 18:14:04 +0100
Message-ID: <4385F4DC.2040503@de.bosch.com>
References: <c43be92d0511182105h6bb9f274q62925dcef7b59ca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c43be92d0511182105h6bb9f274q62925dcef7b59ca8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ajaya Babu Anne <anneajaya@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ajaya Babu Anne wrote:
> Yes ! Perhaps this is manifested in L/R channel Interchange problem, Audio (
> OSS ) driver omap-audio-dma-intfc.c When Audio stream underflow's it does
> not stop the McBSP interface and it continues to underflow. Once data is
> there audio driver start dma chian gain, however McBSP is still in
> operation.
> 
> I have a quick hack to it
> 
> if (!s->started) {
> 
> s->hw_stop_stream( ); /* stops McBSP Interface */
> omap_start_dma(channel);
> s->started = 1;
> s->hw_start_stream( ); /* start McBSP interface */
> 
> }


Just want to test this because of issues with DMA and ALSA driver. But I 
can't find what is behind

s->hw_stop_stream( );
s->hw_start_stream( );

Any hint or even better a patch?

Many thanks

Dirk
