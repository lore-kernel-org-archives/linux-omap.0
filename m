From: Andrew Clayton <andrew@digital-domain.net>
Subject: Compiler warning in arch/arm/include/asm/elf.h
Date: Fri, 12 Mar 2010 10:41:54 +0000
Message-ID: <20100312104154.47ba45ee@digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from b.painless.aaisp.net.uk ([81.187.30.52]:50317 "EHLO
	b.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757270Ab0CLKl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 05:41:57 -0500
Received: from omega.digital-domain.net ([217.169.2.51] helo=localhost)
	by b.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <andrew@digital-domain.net>)
	id 1Nq2JW-0003cj-Vo
	for linux-omap@vger.kernel.org; Fri, 12 Mar 2010 10:41:55 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Is this a real problem? linux-omap-2.6 tree as of 49f7ae9f16

  CC      kernel/elfcore.o
In file included from include/linux/elf.h:7,
                 from kernel/elfcore.c:1:
/home/andrew/src/omap/linux-omap-2.6/arch/arm/include/asm/elf.h:101: wa=
rning: =E2=80=98struct task_struct=E2=80=99 declared inside parameter l=
ist
/home/andrew/src/omap/linux-omap-2.6/arch/arm/include/asm/elf.h:101: wa=
rning: its scope is only this definition or declaration, which is proba=
bly not what you want


Cheers,
Andrew
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
