From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 14:26:48 -0500
Message-ID: <782515bb0710251226y2eaa74d4x54c4ba832454e467@mail.gmail.com>
References: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253046F@dlee13.ent.ti.com>
	<31e679430710251124w70f370c5of30b209eacbf8753@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429025304BF@dlee13.ent.ti.com>
	<31e679430710251154p4f87f124h181ffc6a2a8c8dc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430710251154p4f87f124h181ffc6a2a8c8dc1@mail.gmail.com>
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
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Felipe,
On 10/25/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> wonder tusb6010 has been left aside in this board, is that right ? Is
> there any code for such transceiver publicly available yet?
3430SDP has Triton 2 as the transciever. you should be able to see the
similar support in 2430SDP boards also(esp code which supports the
newer boards (5.0 and above).
Regards,
Nishanth Menon
