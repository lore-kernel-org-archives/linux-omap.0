From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PRCM_SYSCONFIG offset now wrong for OMAP2
Date: Tue, 29 May 2007 20:04:45 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0705291954520.19832@utopia.booyaka.com>
References: <3B6D69C3A9EBCA4BA5DA60D91302742901158B15@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901158B15@dlee13.ent.ti.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 29 May 2007, Woodruff, Richard wrote:

> I see that you have entered the wrong offsets for OMAP24XX_PRCM_REVISION 
> and OMAP24XX_PRCM_SYSCONFIG.  0x4 and 0x14 are wrong.  It should be 0x0 
> and 0x10.

Hi Richard,

thanks for the fix.  Care to send a patch, or would you like me to do it?


- Paul
