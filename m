From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: OMAP2430: networking errors
Date: Thu, 17 May 2007 17:01:29 +0300
Message-ID: <57314e840705170701k79f76c5k79649f929bc63066@mail.gmail.com>
References: <57314e840705170639j410cdd26s40370f492fec6f00@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429010254F3@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429010254F3@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 5/17/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > but the OMAP doesn't see the arp reply,
> > and keep sending the arp who-has packets... :(
> Is this a custom board?  What etherent chip is in use?

it's a development board. how do I know which ethernet chip is on it ?

>
> Does networking work at the u-boot level?

Have the same problems, but just sometimes.
I do use tftpboot to load the kernel and fs,
and sometimes I encounter the same problems
(arp-reply packets get ignored).
feels pretty much random behaviour.

Sometimes the DHCP succeeds, too.

>
> If it is using the standard etherent on SDP's I'd say the gpmc timing
> was wrong on your instance.  If its not the same chip add possible
> driver error.

Can you please guide me how do i check the ethernet chip ?
and if it's standard, how do I change the gpmc timing ?

Thank you !
Budhee
