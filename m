From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/2] OMAP: Kill compile warnings
Date: Fri, 25 May 2007 18:23:16 -0500
Message-ID: <782515bb0705251623o4810c35ap87084ee3c66d4932@mail.gmail.com>
References: <20070525231215.GL21314@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47FF0C48@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0C48@dlee13.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Khasim,
On 5/25/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Yes, I had a similar discussion with Dirk, he passed me few pointers yesterday, please see through if it helps....
>        /* Get the debug Device to omap keypad device */
> -       dbg_dev = &(omap_twl4030kp->dev);
> +       dbg_dev = omap_twl4030kp->dev.parent;
That would be redundant:
220         /* Get the debug Device */
221         dbg_dev = &(pdev->dev);
already did that for you.. only, now the messages will show
"input:xyz.." instead of "omap_twl4030:xyz"..
Regards,
Nishanth Menon
