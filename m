From: "Chaiken, Alison" <Alison_Chaiken@mentor.com>
Subject: RE: [RFC 00/15] Device Tree schemas and validation
Date: Sun, 6 Oct 2013 03:02:53 +0000
Message-ID: <60BA5429A0E1584BA3633194F6F993B50E960588@NA-MBX-03.mgc.mentorg.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524B4B20.4020002@wwwdotorg.org>
 <20131002142914.GI6506@voom.fritz.box>,<524D76DF.9050800@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:54797 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab3JFDDE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Oct 2013 23:03:04 -0400
In-Reply-To: <524D76DF.9050800@baylibre.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "khilman@linaro.org" <khilman@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "fparent@baylibre.com" <fparent@baylibre.com>

Rob Herring in devicetree/msg06598.html
> This is interesting approach using the dts syntax,

Benoit Cousson in devicetree/msg06617.html
> it has the big advantage of re-using the parser already included in DTC for
> free. In term or readability, it avoids to re-defining a brand new syntax for
> people who are already familiar with the DTS one.

Stephen Warren wrote in devicetree/msg06676.html:
> DT is a language for representing data.
> The validation checks described by schemas are rules, or code, and not static
> data.

The syntax of the existing device-tree source is strikingly similar to that of
the widely used JavaScript Object Notation, better known as JSON.  JSON has many
parsers, validators and schemata already in existence.  Assuredly as many coders
know how to program JSON as know C.

JSON makes some sense for representation of device-trees, because, as the
authoritative json.org explains, "JSON is a text format that is completely
language independent but uses conventions that are familiar to programmers of
the C-family of languages . . . JSON is a natural representation of data for the
C family of programming languages."

Benoit Cousson remarks in devicetree/msg06617.html:
> The bindings definition being quite open, there is no easy way to
> ensure proper schema / bindings without careful review of the
> schema.

Stephen Warren continues in devicetree/msg06676.html:
> Overall, I believe perhaps the single most important aspect of any DT
> schema is schema inheritance or instancing,

David Gibson comments in devicetree/msg06725.html:
> define the notion of dt "patterns" or "templates".  A dt
> pattern is to a dt node or subtree as a regex is to a string - it
> provides a reasonably expressive way of defining a family of dt
> nodes.  These would be defined in an extension / superset of dt
> syntax.

I violently agree with Stephen and David and believe that inheritance
offers a partial solution to the problem Benoit describes.  What about
improving compliance by explicitly making use of inheritance with
device-tree include files?  Suppose we consider supplementing the ARM
tree's skeleton.dtsi tree-root with board.dtsi, cpu.dtsi,
daughtercard.dtsi . . .  Suppose then we require board-level dts files
to include board.dtsi, and furthermore that the CPU node for the board
to be described in a DTSI file that must itself include cpu.dtsi.
Then the dtc itself could in effect check perform some constraint
checking.  Device vendors could offer <arch>.dtsi and <particular
chip>.dtsi that users of those products would be required to include.

A related question: what DTS files will a validator compare against a schema?
Assuredly given the existing ability of nodes and properties in a
hierarchy of include files to override and modify one another, the
post C-preprocessed and compiled single-file is the one wanted, that
is, the output from

	       $CC $CPP_FLAGS -o foo.tmp foo.dts
	       dtc -O dts -i arch/arm/boot/dts foo.tmp

Some other suggestions:

   Let's not make the documentation derived from schemata and DTS files
tree-structured.    Otherwise we end up with GNU info, ahem.

   Stephen Warren previously contributed a useful bindings checklist.  We should
try to roll that checklist into any validator.

Benoit promises in  devicetree/msg06617.html:
> Being the very first one, you might get a free beer... meaning there
> might be such thing as a free beer :-)

I'm presenting a talk about device-tree for Embedded Linux Conference
Europe, http://sched.co/17ozhPE, and hope that some of you come flame
me in person there.  If so, I will actually buy you a free beer, but
not until after the second seminar I must give that afternoon!

-- 
Alison Chaiken
Mentor Embedded Software Division
Fremont, CA
GMT-8
