From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: OMAP2430: networking errors
Date: Thu, 17 May 2007 22:55:29 +0300
Message-ID: <57314e840705171255n5932cba1wf32abffbc6a0baaa@mail.gmail.com>
References: <57314e840705170701k79f76c5k79649f929bc63066@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429010256C1@dlee13.ent.ti.com>
	<57314e840705170935u4791b98cs29504cf57523cbc2@mail.gmail.com>
	<464C9CEC.5070806@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <464C9CEC.5070806@css-design.us>
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
To: Steve Poulsen <spoulsen@css-design.us>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 5/17/07, Steve Poulsen <spoulsen@css-design.us> wrote:
> Also, I would suggest checking your cables and hubs.  One thing I have
> noticed is that if you mess around changing MAC addresses, the ARP
> tables of various devices will end up wrong.   Unplugging and plugging
> your cable into a new slot of your hub (or power cycling your hub),
> should correct that.  The reason I bring this up is that you said U-boot
> sometimes will not reply to the ARP packet.   This is more disturbing
> than a simple case where a driver always fails.

Thank you so much.

Ahh. I wish I was using a hub. somehow those stone-age repeaters always
work. I was using a cheap switch.

I recalled we already had switch problems in our company with another
OMAP. we dismissed that case as a hardware failure. but now I just
guess these boards are somehow fundamentally different than standard
PCs.   I have changed my switch, from some 20$ old one into a decent
piece, and now everything works like a charm (I must say that the
cheap switch works years for me with standard PCs, so I didn't
suspect it).

It'd be interesting to understand why the OMAP has trouble working
with those low cost switches (or the opposite), while standard PCs
seem to work fine with the...   but I guess I won't have the time
to explore it too much... :(

But I'm happy now everything works !

Again, Thank you Steve and Richard for the insights and help !
I learnt a lot all around.
It's so good to have people like you two around.

Bye,
Budhee
