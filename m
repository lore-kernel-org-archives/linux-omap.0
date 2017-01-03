From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
Date: Tue, 3 Jan 2017 12:43:44 -0800
Message-ID: <20170103204343.GC25222@atomide.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
 <20161227175837.28970-2-robertcnelson@gmail.com>
 <CB5C8999-6CAE-41F6-85A6-D2A856BD8011@gmail.com>
 <20170103201103.GB25222@atomide.com>
 <2D5ABB5A-E332-4D77-89EA-9DBF9A2FECFB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2D5ABB5A-E332-4D77-89EA-9DBF9A2FECFB@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Kridner <jkridner@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org, Jason Kridner <jkridner@beagleboard.org>
List-Id: linux-omap@vger.kernel.org

* Jason Kridner <jkridner@gmail.com> [170103 12:30]:
> 
> 
> > On Jan 3, 2017, at 3:11 PM, Tony Lindgren <tony@atomide.com> wrote:
> > 
> > * Jason Kridner <jkridner@gmail.com> [161228 13:27]:
> >> 
> >> 
> >>> On Dec 27, 2016, at 11:58 AM, Robert Nelson <robertcnelson@gmail.com> wrote:
> >>> 
> >>> BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the Ethernet
> >>> replaced by a TI wl1835 wireless module.
> >>> 
> >>> This board can be indentified by the BWAx value after A335BNLT (BBB) in the at24 eeprom:
> >>> BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|]
> >> 
> >> I believe the correct statement is BWxx, but BWBx reserves the option to be software incompatible in some way. My preference is to have it boot anyway, but I believe that is only dependent in the bootloader. 
> > 
> > So does this patch need updating for that?
> 
> No, it is bootloader controlled. 

What about the patch description? Does it need updating or is that
an Acked-by?

Tony
