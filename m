From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Audio L/R Channel Interchanges ( Solved!)
Date: Sun, 27 Nov 2005 18:45:09 +0100
Message-ID: <4389F0A5.8080703@de.bosch.com>
References: <c43be92d0511182105h6bb9f274q62925dcef7b59ca8@mail.gmail.com>	
	<4385F4DC.2040503@de.bosch.com>
	<c43be92d0511242250t43dc6edfx1c632d4ce5a070b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c43be92d0511242250t43dc6edfx1c632d4ce5a070b6@mail.gmail.com>
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
> unfortunately my audio driver is little different as I am using MCBSP2 
> for DAC and MCBSP1 for ADC so it will not work for OSK board. So I just 
> written the changes required in omap-audio-aic23.c for OSK above. Hope 
> this helps.

Yes, thanks. Would be nice if you can have a look if patch I sent in
"Problem with ALSA in 2.6.14-omap2 on OSK" thread is correct?

Thanks

Dirk
