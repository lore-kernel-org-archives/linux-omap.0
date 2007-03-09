From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: TSC2101/2102
Date: Fri, 9 Mar 2007 15:23:09 +0100
Message-ID: <fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
References: <20070309140650.GC4399@bitbox.mine.nu>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070309140650.GC4399@bitbox.mine.nu>
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
To: Imre Deak <imre.deak@solidboot.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>, Nishanth Menon <x0nishan@ti.com>
List-Id: linux-omap@vger.kernel.org

Hiya,

On 09/03/07, Imre Deak <imre.deak@solidboot.com> wrote:
> I'm wondering about the proper way to convert the existing omap-tsc2101
> driver to the SPI framework. Would it make sense to handle it with the
> tsc2102 driver? omap-tsc2101 has only the register read / write interface
> which is the same as in tsc2102.

How about maybe a header file <linux/spi/tsc2xxx.h> shared between
tsc2101/2102 with the register access functions as "static inline"
functions?

Regards,
Andrew
