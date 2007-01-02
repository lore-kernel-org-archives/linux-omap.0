From: tony@atomide.com
Subject: Re: [PATCH]: Workqueue changes for board-h3
Date: Tue, 2 Jan 2007 12:35:24 -0800
Message-ID: <20070102203523.GD9733@atomide.com>
References: <31e679430612280750l77e590e4ice853ef8b4c3d05f@mail.gmail.com>
	<3a5b1be00612281133p5c3e870eybd6a3eacccc2e859@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3a5b1be00612281133p5c3e870eybd6a3eacccc2e859@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal.shah802003@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal.shah802003@gmail.com> [061228 11:43]:
> On 12/28/06, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> >Hello Komal,
> >>> -static void set_trans_mode(void *data)
> >>> +static void set_trans_mode(struct work_struct *data)
> >>>  {
> >>> -       int *mode = data;
> >>> +       int *mode = (int *)data;
> >
> >>Did you tested this patch.? I am not sure this casting is the correct
> >>way to go for it.
> >
> >I'm wondering if that
> >>> +       int *mode = (int *)data;
> >
> >shouldn't be
> >int *mode = (int *) data->data;
> >
> >the second data is a atomic_long_t witch is a volatile int...
> >
> >What does it mean these IrDA Flags??
> >
> >#define IR_SEL          1       /* Selects IrDA */
> 
> Above is customized flag for H4/H3 EVM, as we need to select between
> the IrDA and aGPS module by programming through gpio expander. see
> board-h4.c and board-h3.c for its usage (for enabling/disabling the IR
> TX/RX).
> 
> >#define IR_SIRMODE      2
> >#define IR_FIRMODE      4
> >#define IR_MIRMODE      8
> >
> 
> Above three denotes the capabilities of the transeciver, meaning which
> speeds are supported by it.

Can you please try Dirk's patch for H3?

Tony
