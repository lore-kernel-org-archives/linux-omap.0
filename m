From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: OMAP2430: networking errors
Date: Thu, 17 May 2007 17:48:37 +0300
Message-ID: <57314e840705170748h5c94ca67md85b1c7245ec9e0@mail.gmail.com>
References: <57314e840705170639j410cdd26s40370f492fec6f00@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429010254F3@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429010254F3@dlee13.ent.ti.com>
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
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 5/17/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > but the OMAP doesn't see the arp reply,
> > and keep sending the arp who-has packets... :(
> >
> > anyone knows why this may be happening ?
> > or any ideas how to debug this further ?
>
> Is this a custom board?  What etherent chip is in use?

It is SMC LAN91C96. is it standard ?
the driver which is loaded is smc91x.c

>
> Does networking work at the u-boot level?
>
> If it is using the standard etherent on SDP's I'd say the gpmc timing
> was wrong on your instance.  If its not the same chip add possible
> driver error.
>
> Regards,
> Richard W.
>
