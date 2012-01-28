From: Paul Walmsley <paul@pwsan.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Sat, 28 Jan 2012 02:51:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201280251020.13783@utopia.booyaka.com>
References: <4F206213.9070704@flatfrog.com>
 <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com>
 <4F2127B8.9000005@flatfrog.com> <4F213ED8.2020500@flatfrog.com>
 <alpine.DEB.2.00.1201260801410.11174@utopia.booyaka.com>
 <OF645D734B.78418504-ONC1257991.005A101B-C1257991.005A7809@transmode.se>
 <alpine.DEB.2.00.1201260934190.11174@utopia.booyaka.com>
 <alpine.DEB.2.00.1201260936440.11174@utopia.booyaka.com>
 <OF4651C12F.58F763E5-ONC1257991.005C0D05-C1257991.005C4F23@transmode.se>
 <alpine.DEB.2.00.1201260953550.32667@utopia.booyaka.com>
 <OFDD72D713.95FC023B-ONC1257991.005F7988-C1257991.00607681@transmode.se>
 <OF98F390C1.0794131C-ONC1257991.006D971F-C1257991.006DF8A8@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <OF98F390C1.0794131C-ONC1257991.006D971F-C1257991.006DF8A8@transmode.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Richard Purdie <rpurdie@openedhand.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Orjan Friberg <of@flatfrog.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 26 Jan 2012, Joakim Tjernlund wrote:

> .. and you should delay the second allocation to when it is needed. After swapping ptrs, test if
> tmp_buf is NULL and kmalloc if so.

Hmm.  You are thinking of a GFP_ATOMIC allocation?  Seems best to avoid 
those?


- Paul

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
