From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter Card
 Support
Date: Sun, 11 Jan 2009 21:15:56 -0200
Message-ID: <20090111211556.25d9d3c4@pedra.chehab.org>
References: <hvaibhav@ti.com>
	<1231308470-31159-1-git-send-email-hvaibhav@ti.com>
	<1231551681.4474.238.camel@tux.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1231551681.4474.238.camel@tux.localhost>
Sender: linux-media-owner@vger.kernel.org
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: hvaibhav@ti.com, video4linux-list@redhat.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 10 Jan 2009 04:41:21 +0300
Alexey Klimov <klimov.linux@gmail.com> wrote:

> On Wed, 2009-01-07 at 11:37 +0530, hvaibhav@ti.com wrote:
>  [...]  
> 
> You have a lot of dprintk messages. May be it's better to move "\n" to
> dprintk definition? And use dprintk without \n.
> Probably, makes your life easier :)

Please, don't. On almost all places where *print* is used, \n is required.
Moving the end of line character into dprintk will just be something non-standard.

> > +		return -EPERM;
> > +	}
> > +
> > +
> > +	switch (mux_id) {
> > +	case MUX_TVP5146:
> > +		/* active low signal. set 0 to enable, 1 to disable */
> > +		if (ENABLE_MUX == value) {
> > +			/* pull down the GPIO GPIO134 = 0 */
> > +			gpio_set_value(GPIO134_SEL_Y, 0);
> > +			/* pull up the GPIO GPIO54 = 1 */
> > +			gpio_set_value(GPIO54_SEL_EXP_CAM, 1);
> > +			/* pull up the GPIO GPIO136 = 1 */
> > +			gpio_set_value(GPIO136_SEL_CAM, 1);
> > +		} else
> > +			/* pull up the GPIO GPIO134 = 0 */
> > +			gpio_set_value(GPIO134_SEL_Y, 1);  
> 
> Well, please chech the Documentation/CodingStyle file.
> Comments there say that you should use bracers with else expression
> (statement?) also. Care to reformat the patch that it will look like:

Agreed, but, in this specific case, just remove above the comments, or replace
to something more useful. 
Currently, they are just repeating what the code is saying. The comments should
document why you need to change the gpio. Something like:

		/* Enable device foo */
		gpio_set_value(GPIO136_bar, 1);

Cheers,
Mauro
