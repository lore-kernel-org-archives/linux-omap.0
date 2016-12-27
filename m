From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] mach-omap2: fixing wrong strcat for Non-NULL
 terminated string
Date: Tue, 27 Dec 2016 09:40:18 -0800
Message-ID: <20161227174018.GT4920@atomide.com>
References: <1481170230-2120-1-git-send-email-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1481170230-2120-1-git-send-email-maninder1.s@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maninder Singh <maninder1.s@samsung.com>
Cc: Vaneet Narang <v.narang@samsung.com>, paul@pwsan.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, ajeet.y@samsung.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, pankaj.m@samsung.com
List-Id: linux-omap@vger.kernel.org

* Maninder Singh <maninder1.s@samsung.com> [161207 20:16]:
> Issue caught with static analysis tool:
> "Dangerous usage of 'name' (strncpy doesn't always 0-terminate it)"
> 
> Use strlcpy _includes_ the NUL terminator, and  strlcat() which ensures 
> that it won't overflow the buffer.

Applying into omap-for-v4.10/fixes thanks.

Tony
