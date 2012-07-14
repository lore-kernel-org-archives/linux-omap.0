From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: Mis?use of aliases
Date: Sat, 14 Jul 2012 07:07:17 -1000
Message-ID: <5001A745.3000509@firmworks.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com> <50010402.3050502@firmworks.com>
 <20120714163701.GI11326@truffala.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120714163701.GI11326-MK4v0fQdeXQXU02nzanrWNbf9cGiqdzd@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tarun Kanti DebBarma <tarun.kanti-l0cyMroinI0@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 7/14/2012 6:37 AM, David Gibson wrote:
> On Fri, Jul 13, 2012 at 07:30:42PM -1000, Mitch Bradley wrote:
>>> I'm not sure this is really a good use of aliases. UARTs use aliases
>>> because it is important that the UART number to tty number is known and
>>> fixed.
>>
>> This brings up an issue that I've been meaning to comment on.
>>
>> The use of phandle-valued properties in the aliases node causes real OFW
>> implementations some amount of heartburn.  The Open Firmware standard
>> says that the properties in /aliases are string-valued.  That's
>> important, because aliases are shorthand for fragments of full device
>> specifiers (pathnames that can include arguments to nodes).  Phandles
>> can point to nodes, but can't be relative, and can't encode
>> per-node-component arguments.
> 
> Um, so, properties in /aliases should not have phandle values, flat
> tree or otherwise.  Has this been seen in the wild, or are you being
> misled by the fact that dtc's reference-to-phandle and
> reference-to-path syntax is very similar:


Yes, I was indeed being misled.  Thanks for the clarification.  The
"&fred" syntax is present in the .dts files that I have looked at.

> 
> 	prop = <&fred>;
> Will generate a phandle valued property, but
> 	prop = &fred;
> Will generate a string (path) valued property.
> 
>> For binding a Linux unit number to a device node, I would prefer to
>> decorate the node with a property like "linux,unit#", instead of
>> breaking the standard semantics of /aliases.
> 
> I don't see how using aliases for unit numbering (inherently) breaks
> the semantics of /aliases.  If phandle valued properties are being
> used that is wrong, but it's not necessary for the unit numbering
> anyway.

I agree, the use of string-valued /aliases is not a semantic problem.
That said, I still think that decorating individual nodes is a better
approach, for locality reasons.  But, now that my misunderstanding has
been cleared up, it's a mild preference instead of "heartburn".

For historical reference: The original use of /aliases was as a
component of pathname resolution, which is a "global" function.  In that
usage model, a given alias does not necessarily refer specifically to
exactly one node, so "localizing" an alias inside a node doesn't work.

The new usage for binding to a Linux name could be localized.  My
general preference is to localize whenever possible.  But, again,
breaking that rule in this case is not a huge problem.

Thanks again for zeroing in on my mistake.

Mitch
