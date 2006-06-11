From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 11 Jun 2006 15:50:36 +0300
Message-ID: <448C119C.1060806@solidboot.com>
References: <EA12F909C0431D458B9D18A176BEE4A506200328@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A506200328@dlee02.ent.ti.com>
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

Woodruff, Richard wrote:

> I picked up this encoding from USB which uses it also.  In general it
> makes any kind of porting and sharing between some of our internal code
> bases easier.  It has a nice property of also being more compact (in C
> file coding space) then other forms.

That encoding has a lot of downsides:

- You're tied to accessing only one instance of the peripheral (trying 
to access e.g. the different GPIO blocks is bound to be ugly).
- You're tied to MMIO.  read_reg/write_reg can basically use whatever 
transport.
- As mentioned before, supporting several base addresses (e.g. on 
different OMAPs) becomes a hassle.

read_reg/write_reg, in my opinion, doesn't.  You mention compactness as 
one, but with some preprocessor trickery it's rather easy to come up 
with a very compact read_reg/write_reg notation.

But all in all, this is mostly a readability issue, and therefore 
subject to personal preferences.  Mine is read_reg/write_reg. =)

Cheers,
Juha
