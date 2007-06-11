From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Query regarding omap_set_dma_transfer_params()
Date: Mon, 11 Jun 2007 20:38:34 +0530
Message-ID: <61445c750706110808o568603bfy633558cd72afba6a@mail.gmail.com>
References: <61445c750706110756k39f09613ge0e7eedd0befe51f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <61445c750706110756k39f09613ge0e7eedd0befe51f@mail.gmail.com>
Content-Disposition: inline
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
List-Id: linux-omap@vger.kernel.org

On 6/11/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hi,
>
> I am trying to configure the DMA channels in my ALSA driver.  Functions like
>
> void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
>                               unsigned long dest_start,
>                               int dst_ei, int dst_fi)
> and omap_set_dma_src_params() are used for configuration.
>
> What the last two fields i.e dst_ie and dst_fi mean here?
>
> I think this has to do something with interrupts etc but not sure about it. Also
> I couldn't see those fields being populated anywhere in source (they are 0 everywhere).
> I am referring 2.6.19-omap1.
>
> Also, I think that these are unnecessarily exported, since the function omap_set_dma_params()
> is already exported and it calls the above mentioned functions.  And normally the sequence of
> configuring the DMA channel is like
>
> -set src params
> -set dest params
> -set transfer params
>
> -pharaoh.
>

I found it.....

struct omap_dma_channel_params {

----

----
int src_ei;             /* source element index */
int src_fi;             /* source frame index */
int dst_ei;             /* source element index */
int dst_fi;             /* source frame index */

------


}

-pharaoh.
