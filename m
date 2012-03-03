From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP totally fucked?
Date: Sat, 3 Mar 2012 15:46:50 +0000
Message-ID: <20120303154650.GA16132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59223 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2CCPq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 10:46:56 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

There's not much more to say other than that in the subject over this
level of build breakage:

http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=267
http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=268

which is the result of building:

commit 812108a6044b7b8978329ededb3171be89918a4f
Merge: 8fe6b99 85631d2
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Mar 2 09:27:55 2012 +0000

    Merge remote-tracking branch 'arm-soc'
    
    Conflicts:
        arch/arm/Kconfig
        arch/arm/mach-vexpress/Kconfig

commit 8fe6b99253c69412b08cb541155791ada1ba202a
Merge: 8a27184 605ade3 492f076
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Mar 2 09:23:30 2012 +0000

    Merge branches 'private-fixes' and 'sa11x0-asoc' into devel-3.3

commit 85631d264c35ed7fc43fd92a9f0b0d48b6dbd839
Merge: 92601fd 76374c6
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Mar 1 14:01:56 2012 +0000

    Merge branch 'fixes' into for-next
