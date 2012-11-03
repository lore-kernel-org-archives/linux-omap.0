From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 02/15] ARM: OMAP2+: mailbox: Add support for AM33XX
Date: Sat, 3 Nov 2012 08:39:21 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFE61A@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-3-git-send-email-vaibhav.bedia@ti.com>
 <CA+Bv8XY8x=BDgGDNHPMRqz3xUbzKf8+o0MJQDovHY+NqBh6NVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Bv8XY8x=BDgGDNHPMRqz3xUbzKf8+o0MJQDovHY+NqBh6NVw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Russ,

On Sat, Nov 03, 2012 at 05:44:21, Russ Dill wrote:
[...]
> > -       if (!cpu_is_omap44xx())
> > +       if (!cpu_is_omap44xx() || !soc_is_am33xx())
> >                 bit = mbox_read_reg(p->irqdisable) & ~bit;
> 
> Do you mean &&?
> 

I didn't change that line but it looks ok to me :)

Regards,
Vaibhav
