From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: OMAP2430: networking errors
Date: Thu, 17 May 2007 19:35:27 +0300
Message-ID: <57314e840705170935u4791b98cs29504cf57523cbc2@mail.gmail.com>
References: <57314e840705170701k79f76c5k79649f929bc63066@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429010256C1@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429010256C1@dlee13.ent.ti.com>
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
>
> > it's a development board. how do I know which ethernet chip is on it ?
>
> Ok.  Is it the TI-SDP2430 development board?
yes. ethernet chip: SMC 91C96.

>
> If so, what images are you using?  Did you build them or use pre-built
> ones.
I built it. used TI's BSP. it is based on kernel 2.6.10.
I am now cloning myself a copy of Tony's git tree.
I will try to build it, maybe that will help.

otherwise I guess I would have no choice but debug smc91x.c ?

>
> Why do you report your MAC address as  yy:yy:yy:yy:yy:yy.  Is that what
> the driver said or did you remove it for some reason.
oh, you will have to forgive me here.
I usually remove personal data from posts to public mailing lists.

>
> If it works sometimes and not other times that is odd.  Are you using
> the same MAC address on multiple board or something?
hmm, the MAC address is the real hardware one. AFAIK it is
unique for that specific board.

Thank You !
Budhee
