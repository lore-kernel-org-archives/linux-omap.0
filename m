From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: cpu_is_omap15xx() doesn't get set for OMAP310
Date: Thu, 4 Sep 2008 22:10:36 +0100
Message-ID: <20080904211036.GH2309@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36392 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbYIDVKs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 17:10:48 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

While trying out some of the changes in qemu (which emulates an OMAP310)
I found that cpu_is_omap15xx() returns false.

The comment says:

 * Macros to group OMAP into cpu classes.
 * These can be used in most places.
 * cpu_is_omap7xx():    True for OMAP730
 * cpu_is_omap15xx():   True for OMAP1510, OMAP5910 and OMAP310

and cpu_is_omap15xx() is defined as:

#  define cpu_is_omap15xx()             is_omap15xx()

#define GET_OMAP_CLASS  ((system_rev >> 24) & 0xff)

#define IS_OMAP_CLASS(class, id)                        \
static inline int is_omap ##class (void)                \
{                                                       \
        return (GET_OMAP_CLASS == (id)) ? 1 : 0;        \
}

IS_OMAP_CLASS(15xx, 0x15)


So, it's looking for the top byte of system_rev to be 0x15.  However,
the ID table in arch/arm/mach-omap1/id.c contains:

{ .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type = 0x03100000},

so the top byte contains 0x03.  Moreover, it goes on to say:

        /* Add the cpu class info (7xx, 15xx, 16xx, 24xx) */
        cpu_type = system_rev >> 24;
        switch (cpu_type) {
        case 0x03:
                system_rev |= 0x15;
                break;

So, if this code is supposed to be setting the cpu class, it's setting
it in the low byte.

It looks to me like the omap1 ID code is out of step with the omap2 ID
code, or omap310 ID support is broken.
