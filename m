From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 3/5] mfd: twl4030-power: Move power-related data closer
  together in the header file
Date: Mon, 19 Oct 2009 21:33:48 +0200
Message-ID: <20091019213348.28e93f29@hyperion.delvare>
References: <1255954211-28496-1-git-send-email-amit.kucheria@verdurent.com>
	<1255954252-29017-1-git-send-email-amit.kucheria@verdurent.com>
	<20091019191232.GA30203@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757359AbZJSTds@vger.kernel.org>
In-Reply-To: <20091019191232.GA30203@sortiz.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, List Linux Kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 19 Oct 2009 21:12:33 +0200, Samuel Ortiz wrote:
> Hi Amit,
> 
> On Mon, Oct 19, 2009 at 03:10:52PM +0300, Amit Kucheria wrote:
> > Bring together all the TWL power-related data in the header file
> I dont really see the point of doing this, as you're not really gathering
> scattered structures but rather moving a group of definitions up in the header
> file.
> If you dont mind I'll drop this one, unless Jean wants to take it.

No, I don't care about this at all ;)

-- 
Jean Delvare
