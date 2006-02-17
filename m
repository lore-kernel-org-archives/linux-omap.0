From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: OMAP: Update OMAP keypad driver
Date: Fri, 17 Feb 2006 13:06:31 -0800 (PST)
Message-ID: <20060217210632.44544.qmail@web32913.mail.mud.yahoo.com>
References: <20060217163052.GC20494@vasa.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060217163052.GC20494@vasa.acc.umu.se>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Weinehall <tao@acc.umu.se>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- David Weinehall <tao@acc.umu.se> wrote:
> > Before that can't we convert the code below in keypad to
> > 
> > 253 down(&kp_enable_mutex);
> > 254 	if (state != kp_enable) {
> > 255 	if (state)
> > 256 		enable_irq(INT_KEYBOARD);
> > 257 	else
> > 258 		disable_irq(INT_KEYBOARD);
> > 259 		kp_enable = state;
> > 260 }
> > 261 up(&kp_enable_mutex);
> 
> Either you've indented incorrectly here, or you have a bug.

Yes, indentation got lost while I had copy pasted code from Firefox to
e-mail editor, but my point was to use mutex apis and replace
INT_KEYBOARD with platform driver data instead.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
