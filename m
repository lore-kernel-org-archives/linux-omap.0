From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next caused by 95026658c46e i2c: do not use internal..
Date: Mon, 14 Mar 2016 09:09:45 -0700
Message-ID: <20160314160944.GG9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Sudip & Wolfram,

Looks like commit 95026658c46e ("i2c: do not use internal data from
driver core") in Linux next introduced a regression breaking booting
on most ARM boards according to kernelci.org [0].

Having something like this happen just as the merge window opens is
not nice. You guys should already know.. The patches in next should
be sitting there for a few weeks before the merge window so issues
like this are found out early.

Regards,

Tony

[0] https://kernelci.org/boot/all/job/next/
