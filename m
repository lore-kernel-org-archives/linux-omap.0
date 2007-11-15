From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] OMAP: Update ov9640 ifparm for H3 board.
Date: Wed, 14 Nov 2007 17:46:43 -0800
Message-ID: <20071115014642.GB6005@atomide.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
	<1191934353-24072-2-git-send-email-edubezval@gmail.com>
	<1191934353-24072-3-git-send-email-edubezval@gmail.com>
	<20071031104110.GB31081@atomide.com>
	<a0580c510711010832q5d6c9c05o8bf3f81682fad217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <a0580c510711010832q5d6c9c05o8bf3f81682fad217@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Eduardo Valentin <edubezval@gmail.com> [071101 08:32]:
> Hi Tony,
> 
> I'm re-sending the patch. As I said, it was based on board-h4.c. But I
> totally agree with you. I believe this new one is a better way to
> implement it. Unnecessary structures and functions are not created if
> the OV9640 is not selected. I've just compiled tested this new patch.

Thanks for updating it. I'll push the whole series today.

Tony
